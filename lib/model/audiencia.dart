// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Audiencia {
  String codigo;
  String titulo;
  String sala;
  String nrLugares;
  String data;
  String emailRequerente;
  String emailRequerido;

  Audiencia({
    required this.codigo,
    required this.titulo,
    required this.sala,
    required this.nrLugares,
    required this.data,
    required this.emailRequerente,
    required this.emailRequerido,
  });

  Audiencia.fromJsonFire(Map<String, dynamic> json)
      : codigo = json['codigo'],
        titulo = json['titulo'],
        sala = json['sala'],
        nrLugares = json['nrLugares'],
        data = json['data'],
        emailRequerente = json['emailRequerente'],
        emailRequerido = json['emailRequerido'];

  Audiencia copyWith({
    String? codigo,
    String? titulo,
    String? sala,
    String? nrLugares,
    String? data,
    String? emailRequerente,
    String? emailRequerido,
  }) {
    return Audiencia(
      codigo: codigo ?? this.codigo,
      titulo: titulo ?? this.titulo,
      sala: sala ?? this.sala,
      nrLugares: nrLugares ?? this.nrLugares,
      data: data ?? this.data,
      emailRequerente: emailRequerente ?? this.emailRequerente,
      emailRequerido: emailRequerido ?? this.emailRequerido,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'titulo': titulo,
      'sala': sala,
      'nrLugares': nrLugares,
      'data': data,
      'emailRequerente': emailRequerente,
      'emailRequerido': emailRequerido,
    };
  }

  factory Audiencia.fromMap(Map<String, dynamic> map) {
    return Audiencia(
      codigo: map['codigo'] as String,
      titulo: map['titulo'] as String,
      sala: map['sala'] as String,
      nrLugares: map['nrLugares'] as String,
      data: map['data'] as String,
      emailRequerente: map['emailRequerente'] as String,
      emailRequerido: map['emailRequerido'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Audiencia.fromJson(String source) =>
      Audiencia.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Audiencia(codigo: $codigo,codigo: $codigo, sala: $sala, nrLugares: $nrLugares, data: $data, emailRequerente: $emailRequerente, emailRequerido: $emailRequerido)';
  }

  @override
  bool operator ==(covariant Audiencia other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.titulo == titulo &&
        other.sala == sala &&
        other.nrLugares == nrLugares &&
        other.data == data &&
        other.emailRequerente == emailRequerente &&
        other.emailRequerido == emailRequerido;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        titulo.hashCode ^
        sala.hashCode ^
        nrLugares.hashCode ^
        data.hashCode ^
        emailRequerente.hashCode ^
        emailRequerido.hashCode;
  }
}
