import 'dart:convert';

class Process {
  String nprocess;
  String estado;
  DateTime dataInicio;
  String tipo;
  String areaAtuacao;
  String requerido;
  String requerente;
  String titulo;
  String parecer;
  String juiz;
  String seccao;
  String advogadoRequerido;
  String advogadoRequerente;
  int incremento;

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
      DateTime? dataInicio,
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
      int? incremento}) {
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
      'dataInicio': dataInicio.millisecondsSinceEpoch,
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

  factory Process.fromMap(Map<String, dynamic> map) {
    return Process(
      map['nprocess']?.toInt() ?? 0,
      map['estado'] ?? false,
      DateTime.fromMillisecondsSinceEpoch(map['dataInicio']),
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
