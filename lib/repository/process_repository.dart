import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/process.dart';

class ProcessRepository extends ChangeNotifier {
  List<Process> processos = [];

  Stream<List<Process>> getFromDB() => FirebaseFirestore.instance
      .collection('process')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Process.fromMap(doc.data())).toList());

  Process getProcess(String nprocesso) {
    Process processo =
        processos.where((element) => element.nprocess == nprocesso).single;
    print("Processo $nprocesso Retornado");
    return processo;
  }

  List<Process> getAll() => processos;

  void addProcess(Process processo) {
    processos.add(processo);
    print("Processo Adicionado");
    ChangeNotifier();
  }

  void removeProcess(String nprocess) {
    if (processos.any((element) => element.nprocess == nprocess) == true) {
      Process process =
          processos.where((element) => element.nprocess == nprocess).single;
      processos.remove(process);
      print("Processo Removido");
      ChangeNotifier();
    }
  }

  void updateProcess(Process processo) {
    processos[processos.indexWhere(
        (element) => element.nprocess == processo.nprocess)] = processo;
    print("Processo Actualizado");
    ChangeNotifier();
  }

  bool isExistenteProcess(String nprocess) {
    return processos.any((element) => element.nprocess == nprocess);
  }
}
