// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sentenca {
  String codigo;
  String codProcesso;
  String data;
  String tituloProcesso;
  String requerido;
  String emailRequerido;
  String requerente;
  String emailRequerente;
  String estado;
  String parecer;
  Sentenca({
    required this.codigo,
    required this.codProcesso,
    required this.data,
    required this.tituloProcesso,
    required this.requerido,
    required this.emailRequerido,
    required this.requerente,
    required this.emailRequerente,
    required this.estado,
    required this.parecer,
  });

  Sentenca copyWith({
    String? codigo,
    String? codProcesso,
    String? data,
    String? tituloProcesso,
    String? requerido,
    String? emailRequerido,
    String? requerente,
    String? emailRequerente,
    String? estado,
    String? parecer,
  }) {
    return Sentenca(
      codigo: codigo ?? this.codigo,
      codProcesso: codProcesso ?? this.codProcesso,
      data: data ?? this.data,
      tituloProcesso: tituloProcesso ?? this.tituloProcesso,
      requerido: requerido ?? this.requerido,
      emailRequerido: emailRequerido ?? this.emailRequerido,
      requerente: requerente ?? this.requerente,
      emailRequerente: emailRequerente ?? this.emailRequerente,
      estado: estado ?? this.estado,
      parecer: parecer ?? this.parecer,
    );
  }

  Sentenca.fromJsonFire(Map<String, dynamic> json)
      : codigo = json['codigo'],
        codProcesso = json['codProcesso'],
        data = json['data'],
        tituloProcesso = json['tituloProcesso'],
        estado = json['estado'],
        parecer = json['parecer'],
        requerido = json['requerido'],
        emailRequerido = json['emailRequerido'],
        requerente = json['requerente'],
        emailRequerente = json['emailRequerente'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'codProcesso': codProcesso,
      'data': data,
      'tituloProcesso': tituloProcesso,
      'requerido': requerido,
      'emailRequerido': emailRequerido,
      'requerente': requerente,
      'emailRequerente': emailRequerente,
      'estado': estado,
      'parecer': parecer,
    };
  }

  factory Sentenca.fromMap(Map<String, dynamic> map) {
    return Sentenca(
      codigo: map['codigo'] as String,
      codProcesso: map['codProcesso'] as String,
      data: map['data'] as String,
      tituloProcesso: map['tituloProcesso'] as String,
      requerido: map['requerido'] as String,
      emailRequerido: map['emailRequerido'] as String,
      requerente: map['requerente'] as String,
      emailRequerente: map['emailRequerente'] as String,
      estado: map['estado'] as String,
      parecer: map['parecer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sentenca.fromJson(String source) =>
      Sentenca.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sentenca(codigo: $codigo, codProcesso: $codProcesso, data: $data, tituloProcesso: $tituloProcesso, requerido: $requerido, emailRequerido: $emailRequerido, requerente: $requerente, emailRequerente: $emailRequerente, estado: $estado, parecer: $parecer)';
  }

  @override
  bool operator ==(covariant Sentenca other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.codProcesso == codProcesso &&
        other.data == data &&
        other.tituloProcesso == tituloProcesso &&
        other.requerido == requerido &&
        other.emailRequerido == emailRequerido &&
        other.requerente == requerente &&
        other.emailRequerente == emailRequerente &&
        other.estado == estado &&
        other.parecer == parecer;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        codProcesso.hashCode ^
        data.hashCode ^
        tituloProcesso.hashCode ^
        requerido.hashCode ^
        emailRequerido.hashCode ^
        requerente.hashCode ^
        emailRequerente.hashCode ^
        estado.hashCode ^
        parecer.hashCode;
  }
}
