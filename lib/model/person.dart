import 'dart:convert';

class Person {
  String codigo;
  String telefone;
  String nome;
  String apelido;
  String endereco;
  String nrBI;
  String profissao;
  String email;
  String estadoCivil;
  String tipo;
  String genero;

  Person(
    this.codigo,
    this.telefone,
    this.nome,
    this.apelido,
    this.endereco,
    this.nrBI,
    this.profissao,
    this.email,
    this.estadoCivil,
    this.tipo,
    this.genero,
  );

  Person copyWith({
    String? codigo,
    String? telefone,
    String? nome,
    String? apelido,
    String? endereco,
    String? nrBI,
    String? profissao,
    String? email,
    String? estadoCivil,
    String? tipo,
    String? genero,
  }) {
    return Person(
      codigo ?? this.codigo,
      telefone ?? this.telefone,
      nome ?? this.nome,
      apelido ?? this.apelido,
      endereco ?? this.endereco,
      nrBI ?? this.nrBI,
      profissao ?? this.profissao,
      email ?? this.email,
      estadoCivil ?? this.estadoCivil,
      tipo ?? this.tipo,
      genero ?? this.genero,
    );
  }

  Person.fromJsonFire(Map<String, dynamic> json)
      : codigo = json['codigo'],
        telefone = json['telefone'],
        nome = json['nome'],
        apelido = json['apelido'],
        endereco = json['endereco'],
        nrBI = json['nrBI'],
        profissao = json['profissao'],
        email = json['email'],
        estadoCivil = json['estadoCivil'],
        tipo = json['tipo'],
        genero = json['genero'];

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'telefone': telefone,
      'nome': nome,
      'apelido': apelido,
      'endereco': endereco,
      'nrBI': nrBI,
      'profissao': profissao,
      'email': email,
      'estadoCivil': estadoCivil,
      'tipo': tipo,
      'genero': genero,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      map['codigo']?.toInt() ?? 0,
      map['telefone']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['apelido'] ?? '',
      map['endereco'] ?? '',
      map['nrBI'] ?? '',
      map['profissao'] ?? '',
      map['email'] ?? '',
      map['estadoCivil'] ?? '',
      map['tipo'] ?? '',
      map['genero'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(codigo: $codigo, telefone: $telefone, nome: $nome, apelido: $apelido, endereco: $endereco, nrBI: $nrBI, profissao: $profissao, email: $email, estadoCivil: $estadoCivil, tipo: $tipo, genero: $genero)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.codigo == codigo &&
        other.telefone == telefone &&
        other.nome == nome &&
        other.apelido == apelido &&
        other.endereco == endereco &&
        other.nrBI == nrBI &&
        other.profissao == profissao &&
        other.email == email &&
        other.estadoCivil == estadoCivil &&
        other.tipo == tipo &&
        other.genero == genero;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        telefone.hashCode ^
        nome.hashCode ^
        apelido.hashCode ^
        endereco.hashCode ^
        nrBI.hashCode ^
        profissao.hashCode ^
        email.hashCode ^
        estadoCivil.hashCode ^
        tipo.hashCode ^
        genero.hashCode;
  }
}
