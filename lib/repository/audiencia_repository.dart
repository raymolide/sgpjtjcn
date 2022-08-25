import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/audiencia.dart';

class AudienciaRepository extends ChangeNotifier {
  List<Audiencia> audiencias = [];

  Future<List<Audiencia>> getData() async {
    audiencias.clear();
    var db = FirebaseFirestore.instance;
    var dados = await db.collection("audiencia").get().then(
          (res) => res.docs.map((snapshot) {
            return snapshot.data();
          }),
          onError: (e) => print("Error completing: $e"),
        );

    dados.forEach((value) {
      try {
        if (value != null) {
          audiencias.add(Audiencia.fromJsonFire(value));
        }
      } catch (e) {
        print("Audiencia Error: $e");
      }
    });

    return audiencias;
  }

  Audiencia getAudiencia(String codigo) {
    Audiencia audiencia =
        audiencias.where((element) => element.codigo == codigo).first;
    print("Audiencia $codigo Retornado");
    return audiencia;
  }

  List<Audiencia> getAll() {
    audiencias
        .sort((a, b) => int.parse(a.codigo).compareTo(int.parse(b.codigo)));

    return audiencias.reversed.toList();
  }

  void addAudiencia(Audiencia audiencia) {
    audiencias.add(audiencia);
    print("audiencia Adicionado");
    ChangeNotifier();
  }

  void removeAudiencia(String codigo) {
    if (audiencias.any((element) => element.codigo == codigo) == true) {
      Audiencia audiencia =
          audiencias.where((element) => element.codigo == codigo).single;
      audiencias.remove(audiencia);
      print("audiencia Removido");
      ChangeNotifier();
    }
  }

  void updateAudiencia(Audiencia audiencia) {
    audiencias[audiencias.indexWhere(
        (element) => element.codigo == audiencia.codigo)] = audiencia;
    print("Audiencia Actualizado");
    ChangeNotifier();
  }

  bool isExistenteAudiencia(String codigo) {
    return audiencias.any((element) => element.codigo == codigo);
  }
}
