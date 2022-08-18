import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/requerimento.dart';
import 'package:sgpjtjcn/model/rowRequerimento.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/screen/view_process.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/row.dart';

class TableDataReq extends StatefulWidget {
  TableDataReq({Key? key, String? pesquisa}) : super(key: key);
  String? pesquisa;
  @override
  State<TableDataReq> createState() => _TableDataState();
}

class _TableDataState extends State<TableDataReq> {
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
                  Text('Requerimentos Pendentes'),
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
                        hintText: "Pesquisar Requerimento",
                        fillColor: secundaria),
                  ),
                )
              ],
              columns: const [
                DataColumn(label: Text('NRequeriento')),
                DataColumn(label: Text('Motivo')),
                DataColumn(label: Text('Requerimento')),
                DataColumn(label: Text('Estado')),
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
  List<RowTableReq>? _rows;
  int _selectedCount = 0;
  DateFormat formater = DateFormat('dd-MM-yyyy');

  DataSource(this.context, this.pesquisa) {
    _rows = <RowTableReq>[];
    List<Requerimento> requerimentos =
        Provider.of<RequerimentoRepository>(context, listen: false).getAll();

    if (requerimentos.isNotEmpty) {
      for (var element in requerimentos) {
        _rows!.add(RowTableReq(element.nRequerimento, element.motivo,
            element.corpo, element.estado.toString()));
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
