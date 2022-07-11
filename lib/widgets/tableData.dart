import 'package:flutter/material.dart';
import 'package:sgpjtjcn/screen/view_process.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/process.dart';
import 'package:sgpjtjcn/model/row.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';

class TableData extends StatefulWidget {
  TableData({Key? key, String? pesquisa}) : super(key: key);
  String? pesquisa;
  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  String pesquisa = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      SizedBox(
        height: size.height * .7,
        child: ListView(
          children: [
            PaginatedDataTable(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Processos Pendentes'),
                ],
              ),
              rowsPerPage: 10,
              showCheckboxColumn: false,
              actions: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        pesquisa = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Pesquisar Processo",
                        fillColor: secundaria),
                  ),
                )
              ],
              columns: const [
                DataColumn(label: Text('NProcesso')),
                DataColumn(label: Text('Requerido')),
                DataColumn(label: Text('Requerente')),
                DataColumn(label: Text('Data Entrada')),
                DataColumn(label: Text('Título')),
              ],
              source: DataSource(context, pesquisa),
            ),
          ],
        ),
      )
    ]);
  }
}

class DataSource extends DataTableSource {
  String pesquisa = "";
  final BuildContext context;
  List<RowTable>? _rows;
  int _selectedCount = 0;
  DateFormat formater = DateFormat('dd-MM-yyyy');

  DataSource(this.context, this.pesquisa) {
    _rows = <RowTable>[];
    List<Process> processos =
        Provider.of<ProcessRepository>(context, listen: false).getAll();

    if (processos.isNotEmpty) {
      for (var element in processos) {
        _rows!.add(RowTable(element.nprocess, element.requerido,
            element.requerente, element.dataInicio, element.titulo));
      }
    }

    _rows = pesquisa.isNotEmpty
        ? _rows!
            .where((element) =>
                element.valueA.toLowerCase().contains(pesquisa.toLowerCase()) ||
                element.valueB.toLowerCase().contains(pesquisa.toLowerCase()) ||
                element.valueC.toLowerCase().contains(pesquisa.toLowerCase()) ||
                element.valueD.toLowerCase().contains(pesquisa.toLowerCase()))
            .toList()
        : _rows;
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows!.length) return null!;
    final row = _rows![index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(TextButton(
          child: Text(
            row.valueA,
            style: TextStyle(color: Colors.blue[600]),
          ),
          onPressed: () {
            String nprocess = row.valueA;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewProcess(nprocesso: nprocess)));
          },
        )),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE))
      ],
    );
  }

  @override
  int get rowCount => _rows!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
