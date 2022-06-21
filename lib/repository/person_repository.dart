import 'package:flutter/material.dart';
import 'package:sgpjtjcn/model/person.dart';

class PersonRepository extends ChangeNotifier {
  List<Person> pessoas = [];

  Person getPerson(String codigo) {
    Person pessoa = pessoas.where((element) => element.codigo == codigo).single;
    print("Pessoa $codigo Retornado");
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
}
