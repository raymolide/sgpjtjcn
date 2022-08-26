import 'package:sgpjtjcn/model/person.dart';

class Required extends Person {
  String queixa;

  Required(
      this.queixa,
      String codigo,
      String telefone,
      String nome,
      String apelido,
      String endereco,
      String nrBI,
      String profissao,
      String email,
      String estadoCivil,
      String tipo,
      String genero,
      String dataNasc)
      : super(codigo, telefone, nome, apelido, endereco, nrBI, profissao, email,
            estadoCivil, tipo, genero, dataNasc);
}
