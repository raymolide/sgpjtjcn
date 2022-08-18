import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/requerimento.dart';

class RequerimentoRepository extends ChangeNotifier {
  List<Requerimento> requerimentos = [];

  Future<List<Requerimento>> getData() async {
    requerimentos.clear();
    var db = FirebaseFirestore.instance;
    var dados = await db.collection("requerimento").get().then(
          (res) => res.docs.map((snapshot) {
            return snapshot.data();
          }),
          onError: (e) => print("Error completing: $e"),
        );

    dados.forEach((value) {
      try {
        requerimentos.add(Requerimento.fromJsonFire(value));
      } catch (e) {
        print("Erro: $e");
      }
    });

    return requerimentos;
  }

  Requerimento getRequerimento(String nRequerimento) {
    Requerimento requerimento = requerimentos
        .where((element) => element.nRequerimento == nRequerimento)
        .first;
    print("Requerimento $nRequerimento Retornado");
    return requerimento;
  }

  List<Requerimento> getAll() => requerimentos;

  void addRequerimento(Requerimento requerimento) {
    requerimentos.add(requerimento);
    print("requerimento Adicionado");
    ChangeNotifier();
  }

  void removeRequerimento(String nRequerimento) {
    if (requerimentos
            .any((element) => element.nRequerimento == nRequerimento) ==
        true) {
      Requerimento requerimento = requerimentos
          .where((element) => element.nRequerimento == nRequerimento)
          .single;
      requerimentos.remove(requerimento);
      print("requerimento Removido");
      ChangeNotifier();
    }
  }

  void updateRequerimento(Requerimento requerimento) {
    requerimentos[requerimentos.indexWhere(
            (element) => element.nRequerimento == requerimento.nRequerimento)] =
        requerimento;
    print("Requerimento Actualizado");
    ChangeNotifier();
  }

  bool isExistenteRequerimento(String nRequerimento) {
    return requerimentos
        .any((element) => element.nRequerimento == nRequerimento);
  }
}
