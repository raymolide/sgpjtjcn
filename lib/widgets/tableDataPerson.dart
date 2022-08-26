import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/model/rowPerson.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/screen/utilizadores.dart';
import 'package:sgpjtjcn/util/constants.dart';

class TableDataPerson extends StatefulWidget {
  const TableDataPerson({Key? key}) : super(key: key);

  @override
  State<TableDataPerson> createState() => _TableDataPersonState();
}

class _TableDataPersonState extends State<TableDataPerson> {
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
                  Text('Gestão de utilizadores'),
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
                        hintText: "Pesquisar pessoa",
                        fillColor: secundaria),
                  ),
                )
              ],
              columns: const [
                DataColumn(label: Text('Codigo')),
                DataColumn(label: Text('Nome Completo')),
                DataColumn(label: Text('Endereço')),
                DataColumn(label: Text('Telefone')),
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
  List<RowTablePerson>? _rows;
  int _selectedCount = 0;
  DateFormat formater = DateFormat('dd-MM-yyyy');

  DataSource(this.context, this.pesquisa) {
    _rows = <RowTablePerson>[];
    PersonRepository personRepository =
        Provider.of<PersonRepository>(context, listen: false);
    List<Person> pessoas = [];
    PersonRepository reqRepository =
        Provider.of<PersonRepository>(context, listen: false);
    Person pessoa = personRepository.pessoas
        .where((element) => element.email == personRepository.email)
        .first;

    if (pessoa.tipo.toLowerCase() == "parte") {
      pessoas = reqRepository
          .getAll()
          .where((element) => element.email == personRepository.email)
          .toList();
    } else {
      pessoas = reqRepository.getAll();
    }

    if (pessoas.isNotEmpty) {
      for (var element in pessoas) {
        _rows!.add(RowTablePerson(
            element.codigo,
            element.nome + " " + element.apelido,
            element.endereco,
            element.telefone.toString()));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Utilizador(codigo: row.valueA)));
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
