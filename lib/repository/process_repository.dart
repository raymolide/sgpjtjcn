import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/process.dart';

class ProcessRepository extends ChangeNotifier {
  List<Process> processos = [];

  Future<List<Process>> getData() async {
    processos.clear();
    var db = FirebaseFirestore.instance;
    var dados = await db.collection("process").get().then(
          (res) => res.docs.map((snapshot) {
            return snapshot.data();
          }),
          onError: (e) => print("Error completing: $e"),
        );

    dados.forEach((value) {
      try {
        processos.add(Process.fromJsonFire(value));
      } catch (e) {
        print("Erro: $e");
      }
    });

    return processos;
  }

  Process getProcess(String nprocesso) {
    Process processo =
        processos.where((element) => element.nprocess == nprocesso).first;
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
