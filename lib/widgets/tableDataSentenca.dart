import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/audiencia.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/model/rowSentenca.dart';
import 'package:sgpjtjcn/model/sentenca.dart';
import 'package:sgpjtjcn/repository/audiencia_repository.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/sentenca_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TableDataSentenca extends StatefulWidget {
  TableDataSentenca({Key? key, String? pesquisa}) : super(key: key);
  String? pesquisa;
  @override
  State<TableDataSentenca> createState() => _TableDataState();
}

class _TableDataState extends State<TableDataSentenca> {
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
                  Text('Sentencas Marcadas'),
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
                        hintText: "Pesquisar Sentenca",
                        fillColor: secundaria),
                  ),
                )
              ],
              columns: const [
                DataColumn(label: Text('Codigo')),
                DataColumn(label: Text('CodProcesso')),
                DataColumn(label: Text('Titulo')),
                DataColumn(label: Text('Requerido')),
                DataColumn(label: Text('Email Requerido')),
                DataColumn(label: Text('Requerente')),
                DataColumn(label: Text('Email Requerente')),
                DataColumn(label: Text('Decisão'))
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
  List<RowTableSentenca>? _rows;
  int _selectedCount = 0;
  DateFormat formater = DateFormat('dd-MM-yyyy');

  DataSource(this.context, this.pesquisa) {
    _rows = <RowTableSentenca>[];
    PersonRepository personRepository =
        Provider.of<PersonRepository>(context, listen: false);

    List<Sentenca> audiencia = [];
    SentencaRepository sentencaRepository =
        Provider.of<SentencaRepository>(context, listen: false);
    Person pessoa = personRepository.pessoas
        .where((element) => element.email == personRepository.email)
        .first;

    if (pessoa.tipo.toLowerCase() == "parte") {
      audiencia = sentencaRepository
          .getAll()
          .where((element) =>
              element.emailRequerente == personRepository.email ||
              element.emailRequerido == personRepository.email)
          .toList();
    } else {
      audiencia = sentencaRepository.getAll();
    }

    if (audiencia.isNotEmpty) {
      for (var element in audiencia) {
        _rows!.add(RowTableSentenca(
            element.codigo,
            element.codProcesso,
            element.tituloProcesso,
            element.requerido,
            element.emailRequerido,
            element.requerente,
            element.emailRequerente,
            element.estado));
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
        DataCell(Text(row.valueH)),
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
