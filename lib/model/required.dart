import 'package:sgpjtjcn/model/person.dart';

class Required extends Person {
  String queixa;

  Required(
      this.queixa,
      int codigo,
      int telefone,
      String nome,
      String apelido,
      String endereco,
      String nrBI,
      String profissao,
      String email,
      String estadoCivil,
      String tipo,
      String genero)
      : super(codigo, telefone, nome, apelido, endereco, nrBI, profissao, email,
            estadoCivil, tipo, genero);
}
