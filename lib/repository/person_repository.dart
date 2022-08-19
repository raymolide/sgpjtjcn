import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/person.dart';

class PersonRepository extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Person> pessoas = [];
  String email = "";

  Future<List<Person>> getData() async {
    pessoas.clear();
    var db = FirebaseFirestore.instance;
    var dados = await db.collection("person").get().then(
          (res) => res.docs.map((snapshot) {
            return snapshot.data();
          }),
          onError: (e) => print("Error completing: $e"),
        );

    dados.forEach((value) {
      try {
        pessoas.add(Person.fromJsonFire(value));
      } catch (e) {
        print("Erro: $e");
      }
    });

    return pessoas;
  }

  Person getPerson(String email) {
    Person pessoa = pessoas.where((element) => element.email == email).single;
    print("Pessoa $email Retornado");
    return pessoa;
  }

  List<Person> getAll() => pessoas;

  void addPerson(Person pessoa) {
    pessoas.add(pessoa);
    print("Pessoa Adicionada");
    ChangeNotifier();
  }

  void removePerson(String codigo) {
    if (pessoas.any((element) => element.codigo == codigo) == true) {
      Person process =
          pessoas.where((element) => element.codigo == codigo).single;
      pessoas.remove(process);
      print("Pessoa Removida");
      ChangeNotifier();
    }
  }

  void updatePerson(Person pessoa) {
    pessoas[pessoas.indexWhere((element) => element.codigo == pessoa.codigo)] =
        pessoa;
    print("Pessoa Actualizada");
    ChangeNotifier();
  }

  bool isExistentePerson(String codigo) {
    return pessoas.any((element) => element.codigo == codigo);
  }

  Future<bool> register(String email, String password) async {
    bool resposta = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      resposta = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print("Register: $resposta");
    return resposta;
  }

  Future<bool> signIn(String email, String password) async {
    bool resposta = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      resposta = true;
      print("object");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.stackTrace);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    print("Login: $resposta");
    return resposta;
  }
}
