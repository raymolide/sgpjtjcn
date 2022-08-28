import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/sentenca.dart';
import 'package:sgpjtjcn/model/sentenca.dart';

class SentencaRepository extends ChangeNotifier {
  List<Sentenca> sentencas = [];

  Future<List<Sentenca>> getData() async {
    sentencas.clear();
    var db = FirebaseFirestore.instance;
    var dados = await db.collection("sentenca").get().then(
          (res) => res.docs.map((snapshot) {
            return snapshot.data();
          }),
          onError: (e) => print("Error completing: $e"),
        );

    dados.forEach((value) {
      try {
        if (value != null) {
          sentencas.add(Sentenca.fromJsonFire(value));
        }
      } catch (e) {
        print("Sentenca Error: $e");
      }
    });

    return sentencas;
  }

  Sentenca getAudiencia(String codigo) {
    Sentenca sentenca =
        sentencas.where((element) => element.codigo == codigo).first;
    print("Sentenca $codigo Retornado");
    return sentenca;
  }

  List<Sentenca> getAll() {
    sentencas
        .sort((a, b) => int.parse(a.codigo).compareTo(int.parse(b.codigo)));

    return sentencas.reversed.toList();
  }

  void addAudiencia(Sentenca sentenca) {
    sentencas.add(sentenca);
    print("sentenca Adicionado");
    ChangeNotifier();
  }

  void removeAudiencia(String codigo) {
    if (sentencas.any((element) => element.codigo == codigo) == true) {
      Sentenca sentenca =
          sentencas.where((element) => element.codigo == codigo).single;
      sentencas.remove(sentenca);
      print("sentenca Removido");
      ChangeNotifier();
    }
  }

  void updateAudiencia(Sentenca sentenca) {
    sentencas[sentencas
        .indexWhere((element) => element.codigo == sentenca.codigo)] = sentenca;
    print("Sentenca Actualizado");
    ChangeNotifier();
  }

  bool isExistenteAudiencia(String codigo) {
    return sentencas.any((element) => element.codigo == codigo);
  }
}
