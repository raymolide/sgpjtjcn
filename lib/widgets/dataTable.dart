import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/process.dart';
import 'package:sgpjtjcn/model/row.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';

Widget dataTablePendentes(List<DataRow> dados) {
  return DataTable(
      headingRowColor: MaterialStateProperty.all(primary.withOpacity(.9)),
      headingTextStyle: TextStyle(color: Colors.white),
      columnSpacing: 30,
      columns: [
        DataColumn(label: Text("NProcesso")),
        DataColumn(label: Text("Requerido")),
        DataColumn(label: Text("Requerente")),
        DataColumn(label: Text("Data Entrada")),
        DataColumn(label: Text("Título")),
        DataColumn(label: Text("Ver")),
      ],
      rows: dados);
}
