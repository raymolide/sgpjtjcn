import 'dart:convert';

class Process {
  final String nprocess;
  final String estado;
  final String dataInicio;
  final String tipo;
  final String areaAtuacao;
  final String requerido;
  final String requerente;
  final String titulo;
  final String parecer;
  final String juiz;
  final String seccao;
  final String advogadoRequerido;
  final String advogadoRequerente;
  final String incremento;

  Process(
      this.nprocess,
      this.estado,
      this.dataInicio,
      this.tipo,
      this.areaAtuacao,
      this.requerido,
      this.requerente,
      this.titulo,
      this.parecer,
      this.juiz,
      this.seccao,
      this.advogadoRequerido,
      this.advogadoRequerente,
      this.incremento);

  Process copyWith(
      {String? nprocess,
      String? estado,
      String? dataInicio,
      String? tipo,
      String? areaAtuacao,
      String? requerido,
      String? requerente,
      String? titulo,
      String? parecer,
      String? juiz,
      String? seccao,
      String? advogadoRequerido,
      String? advogadoRequerente,
      String? incremento}) {
    return Process(
        nprocess ?? this.nprocess,
        estado ?? this.estado,
        dataInicio ?? this.dataInicio,
        tipo ?? this.tipo,
        areaAtuacao ?? this.areaAtuacao,
        requerido ?? this.requerido,
        requerente ?? this.requerente,
        titulo ?? this.titulo,
        parecer ?? this.parecer,
        juiz ?? this.juiz,
        seccao ?? this.seccao,
        advogadoRequerido ?? this.advogadoRequerido,
        advogadoRequerente ?? this.advogadoRequerente,
        incremento ?? this.incremento);
  }

  Map<String, dynamic> toMap() {
    return {
      'nprocess': nprocess,
      'estado': estado,
      'dataInicio': dataInicio,
      'tipo': tipo,
      'areaAtuacao': areaAtuacao,
      'requerido': requerido,
      'requerente': requerente,
      'titulo': titulo,
      'parecer': parecer,
      'juiz': juiz,
      'seccao': seccao,
      'advogadoRequerido': advogadoRequerido,
      'advogadoRequerente': advogadoRequerente,
      'incremento': incremento
    };
  }

  static Process fromJsonDB(Map<String, dynamic> json) => Process(
      json['nprocess'],
      json['estado'],
      json['dataInicio'],
      json['tipo'],
      json['areaAtuacao'],
      json['requerido'],
      json['requerente'],
      json['titulo'],
      json['parecer'],
      json['juiz'],
      json['seccao'],
      json['advogadoRequerido'],
      json['advogadoRequerente'],
      json['incremento']);

  Process.fromJsonFire(Map<String, dynamic> json)
      : nprocess = json['nprocess'],
        estado = json['estado'],
        dataInicio = json['dataInicio'],
        tipo = json['tipo'],
        areaAtuacao = json['areaAtuacao'],
        requerido = json['requerido'],
        requerente = json['requerente'],
        titulo = json['titulo'],
        parecer = json['parecer'],
        juiz = json['juiz'],
        seccao = json['seccao'],
        advogadoRequerido = json['advogadoRequerido'],
        advogadoRequerente = json['advogadoRequerente'],
        incremento = json['incremento'];

  Process fromJsonF(Map<String, dynamic> json) => copyWith(
      nprocess: json['nprocess'],
      estado: json['estado'],
      dataInicio: json['dataInicio'],
      tipo: json['tipo'],
      areaAtuacao: json['areaAtuacao'],
      requerido: json['requerido'],
      requerente: json['requerente'],
      titulo: json['titulo'],
      parecer: json['parecer'],
      juiz: json['juiz'],
      seccao: json['seccao'],
      advogadoRequerido: json['advogadoRequerido'],
      advogadoRequerente: json['advogadoRequerente'],
      incremento: json['incremento']);

  factory Process.fromMap(Map<String, dynamic> map) {
    return Process(
      map['nprocess'] ?? '',
      map['estado'] ?? false,
      map['dataInicio'],
      map['tipo'] ?? '',
      map['areaAtuacao'] ?? '',
      map['requerido'] ?? '',
      map['requerente'] ?? '',
      map['titulo'] ?? '',
      map['parecer'] ?? '',
      map['juiz'] ?? '',
      map['seccao'] ?? '',
      map['advogadoRequerido'] ?? '',
      map['advogadoRequerente'] ?? '',
      map['incremento'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Process.fromJson(String source) =>
      Process.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Process(nprocess: $nprocess, estado: $estado, dataInicio: $dataInicio, tipo: $tipo, areaAtuacao: $areaAtuacao, requerido: $requerido, requerente: $requerente, titulo: $titulo, parecer: $parecer, juiz: $juiz, seccao: $seccao, advogadoRequerido: $advogadoRequerido, advogadoRequerente: $advogadoRequerente)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Process &&
        other.nprocess == nprocess &&
        other.estado == estado &&
        other.dataInicio == dataInicio &&
        other.tipo == tipo &&
        other.areaAtuacao == areaAtuacao &&
        other.requerido == requerido &&
        other.requerente == requerente &&
        other.titulo == titulo &&
        other.parecer == parecer &&
        other.juiz == juiz &&
        other.seccao == seccao &&
        other.advogadoRequerido == advogadoRequerido &&
        other.advogadoRequerente == advogadoRequerente &&
        other.incremento == incremento;
  }

  @override
  int get hashCode {
    return nprocess.hashCode ^
        estado.hashCode ^
        dataInicio.hashCode ^
        tipo.hashCode ^
        areaAtuacao.hashCode ^
        requerido.hashCode ^
        requerente.hashCode ^
        titulo.hashCode ^
        parecer.hashCode ^
        juiz.hashCode ^
        seccao.hashCode ^
        advogadoRequerido.hashCode ^
        advogadoRequerente.hashCode ^
        incremento.hashCode;
  }
}
