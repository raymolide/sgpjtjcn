import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/audiencia.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/model/requerimento.dart';
import 'package:sgpjtjcn/model/rowAudiencia.dart';
import 'package:sgpjtjcn/model/rowRequerimento.dart';
import 'package:sgpjtjcn/repository/audiencia_repository.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/screen/viewRequerimento.dart';
import 'package:sgpjtjcn/screen/view_process.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/row.dart';

class TableDataAudiencia extends StatefulWidget {
  TableDataAudiencia({Key? key, String? pesquisa}) : super(key: key);
  String? pesquisa;
  @override
  State<TableDataAudiencia> createState() => _TableDataState();
}

class _TableDataState extends State<TableDataAudiencia> {
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
                  Text('Audiencias Marcadas'),
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
                        hintText: "Pesquisar Audiencia",
                        fillColor: secundaria),
                  ),
                )
              ],
              columns: const [
                DataColumn(label: Text('Codigo')),
                DataColumn(label: Text('Titulo')),
                DataColumn(label: Text('Sala')),
                DataColumn(label: Text('Nr. Lugares')),
                DataColumn(label: Text('Data')),
                DataColumn(label: Text('Requerido')),
                DataColumn(label: Text('Requerente')),
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
  List<RowTableAudiencia>? _rows;
  int _selectedCount = 0;
  DateFormat formater = DateFormat('dd-MM-yyyy');

  DataSource(this.context, this.pesquisa) {
    _rows = <RowTableAudiencia>[];
    PersonRepository personRepository =
        Provider.of<PersonRepository>(context, listen: false);

    List<Audiencia> audiencia = [];
    AudienciaRepository audienciaRepository =
        Provider.of<AudienciaRepository>(context, listen: false);
    Person pessoa = personRepository.pessoas
        .where((element) => element.email == personRepository.email)
        .first;

    if (pessoa.tipo.toLowerCase() == "parte") {
      audiencia = audienciaRepository
          .getAll()
          .where((element) =>
              element.emailRequerente == personRepository.email ||
              element.emailRequerido == personRepository.email)
          .toList();
    } else {
      audiencia = audienciaRepository.getAll();
    }

    if (audiencia.isNotEmpty) {
      for (var element in audiencia) {
        _rows!.add(RowTableAudiencia(
            element.codigo,
            element.titulo,
            element.sala,
            element.nrLugares,
            element.data,
            element.emailRequerido,
            element.emailRequerente));
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
            String nReq = row.valueA;
          },
        )),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        DataCell(Text(row.valueG)),
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
