// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sgpjtjcn/model/required.dart';

class Requerimento {
  String nRequerimento;
  String motivo;
  String corpo;
  String nome;
  String email;
  String estado;

  get getNRequerimento => this.nRequerimento;

  set setNRequerimento(String nRequerimento) =>
      this.nRequerimento = nRequerimento;

  get getMotivo => this.motivo;

  set setMotivo(String motivo) => this.motivo = motivo;

  get getCorpo => this.corpo;

  set setCorpo(corpo) => this.corpo = corpo;

  get getNome => this.nome;

  set setNome(String nome) => this.nome = nome;

  get getEmail => this.email;

  set setEmail(String email) => this.email = email;

  get getEstado => this.estado;

  set setEstado(String estado) => this.estado = estado;

  Requerimento({
    required this.nRequerimento,
    required this.motivo,
    required this.corpo,
    required this.nome,
    required this.email,
    required this.estado,
  });

  Requerimento copyWith({
    String? nRequerimento,
    String? nome,
    String? email,
    String? motivo,
    String? corpo,
    String? estado,
  }) {
    return Requerimento(
      nRequerimento: nRequerimento ?? this.nRequerimento,
      motivo: motivo ?? this.motivo,
      corpo: corpo ?? this.corpo,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nRequerimento': nRequerimento,
      'nome': nome,
      'email': email,
      'motivo': motivo,
      'corpo': corpo,
      'estado': estado,
    };
  }

  Requerimento.fromJsonFire(Map<String, dynamic> json)
      : nRequerimento = json['nRequerimento'],
        nome = json['nome'],
        email = json['email'],
        motivo = json['motivo'],
        estado = json['estado'],
        corpo = json['corpo'];

  factory Requerimento.fromMap(Map<String, dynamic> map) {
    return Requerimento(
      nRequerimento: map['nRequerimento'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      motivo: map['motivo'] as String,
      corpo: map['corpo'] as String,
      estado: map['estado'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Requerimento.fromJson(String source) =>
      Requerimento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Requerimento(nRequerimento: $nRequerimento, motivo: $motivo, corpo: $corpo,nome: $nome,email: $email, estado: $estado)';
  }

  @override
  bool operator ==(covariant Requerimento other) {
    if (identical(this, other)) return true;

    return other.nRequerimento == nRequerimento &&
        other.nome == nome &&
        other.email == email &&
        other.motivo == motivo &&
        other.corpo == corpo &&
        other.estado == estado;
  }

  @override
  int get hashCode {
    return nRequerimento.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        motivo.hashCode ^
        corpo.hashCode ^
        estado.hashCode;
  }
}
