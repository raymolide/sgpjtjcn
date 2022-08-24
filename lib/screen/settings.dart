import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/textField.dart';

class MySettings extends StatefulWidget {
  MySettings({Key? key}) : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerApelido = TextEditingController();
  TextEditingController controllerBI = TextEditingController();
  TextEditingController controllerProfissao = TextEditingController();
  TextEditingController controllerdataNascimento = TextEditingController();
  TextEditingController controllerTelefone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerEstadoCivil = TextEditingController();
  TextEditingController controllerGenero = TextEditingController();
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerEndereco = TextEditingController();

  List<String> estadoCivil = [
    'Solteiro/a',
    'Casado/a',
    "Divorciado/a",
    "Viuvo/a"
  ];
  String estado = "Solteiro/a";

  List<String> generos = ['Masculino', 'Feminino'];
  String genero = "Masculino";

  List<String> perfils = ['Admin', "Parte", "Juiz", "Escrivão"];
  String perfil = "Parte";

  late Future<List<Person>> fetchData;

  @override
  void initState() {
    fetchData = Provider.of<PersonRepository>(context, listen: false).getData();
    controllerGenero.text = genero;
    controllerTipo.text = perfil;
    controllerEstadoCivil.text = estado;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PersonRepository repository =
        Provider.of<PersonRepository>(context, listen: false);
    return SizedBox(
        height: size.height - AppBar().preferredSize.height,
        width: size.width,
        child: FutureBuilder<List<Person>>(
            initialData: repository.pessoas,
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isNotEmpty) {
                  List<Person> pessoas = snapshot.data!;
                  pessoas.sort(((a, b) =>
                      int.parse(a.codigo).compareTo(int.parse(b.codigo))));

                  controllerCodigo.text =
                      (int.parse(pessoas.last.codigo) + 1).toString();
                  String email = repository.email;
                  if (pessoas.any((element) => element.email == email)) {
                    preencherDados(pessoas
                        .where((element) => element.email == email)
                        .first);
                  }
                } else {
                  controllerCodigo.text = "1";
                }

                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .15,
                              child: textField(
                                  'Código', Icon(Icons.person, color: primary),
                                  controller: controllerCodigo),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField(
                                  'Nome ', Icon(Icons.person, color: primary),
                                  controller: controllerNome),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField(
                                  'Apelido', Icon(Icons.person, color: primary),
                                  controller: controllerApelido),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Endereço',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerEndereco),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField('Telefone',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerTelefone),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Número BI',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerBI),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField('Profissão',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerProfissao),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Data Nascimento',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerdataNascimento),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Genero",
                                    style: TextStyle(color: primary),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14.0, right: 14),
                                        child: DropdownButton(
                                          hint: Text(genero),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          value: genero,
                                          items: generos.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              genero = value!;
                                              controllerGenero.text = genero;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ddl(context, estado, estadoCivil, "Estado Civil"),
                            Text(
                              "Estado Civil",
                              style: TextStyle(color: primary),
                            ),
                            DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14),
                                  child: DropdownButton(
                                    hint: Text(estado),
                                    style: Theme.of(context).textTheme.button,
                                    alignment: AlignmentDirectional.bottomEnd,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    value: estado,
                                    items: estadoCivil.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        estado = value!;
                                        controllerEstadoCivil.text = estado;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .01),
                            //ddl(context, perfil, perfils, "Tipo de Conta"),
                            Text(
                              "Tipo de conta",
                              style: TextStyle(color: primary),
                            ),
                            IgnorePointer(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 14),
                                    child: DropdownButton(
                                      hint: Text(perfil),
                                      style: Theme.of(context).textTheme.button,
                                      alignment: AlignmentDirectional.bottomEnd,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      value: perfil,
                                      items: perfils.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          perfil = value!;
                                          controllerTipo.text = perfil;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              circleBtn(
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  () {},
                                  splashColor: Colors.blue),
                              circleBtnForm(
                                  const Icon(Icons.save, color: Colors.white),
                                  () async {
                                controllerEmail.text = repository.email;
                                Person pessoa = Person(
                                    controllerCodigo.text,
                                    controllerTelefone.text,
                                    controllerNome.text,
                                    controllerApelido.text,
                                    controllerEndereco.text,
                                    controllerBI.text,
                                    controllerProfissao.text,
                                    controllerEmail.text,
                                    controllerEstadoCivil.text,
                                    controllerTipo.text,
                                    controllerGenero.text);

                                if (repository
                                    .isExistentePerson(controllerCodigo.text)) {
                                  repository.updatePerson(pessoa);
                                  Map<String, dynamic> mapPessoa =
                                      pessoa.toMap();
                                  final reqRef = FirebaseFirestore.instance
                                      .collection('person')
                                      .doc(pessoa.codigo);
                                  await reqRef.update(mapPessoa);
                                } else {
                                  repository.addPerson(pessoa);
                                  Map<String, dynamic> mapPessoa =
                                      pessoa.toMap();
                                  final reqRef = FirebaseFirestore.instance
                                      .collection('person')
                                      .doc(pessoa.codigo);
                                  await reqRef.set(mapPessoa);
                                }
                                Navigator.popAndPushNamed(context, "/pending");
                              }, _formKey, splashColor: Colors.white)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  void preencherDados(Person pessoa) {
    controllerCodigo.text = pessoa.codigo;
    controllerTelefone.text = pessoa.telefone;
    controllerNome.text = pessoa.nome;
    controllerApelido.text = pessoa.apelido;
    controllerEndereco.text = pessoa.endereco;
    controllerBI.text = pessoa.nrBI;
    controllerProfissao.text = pessoa.profissao;
    controllerEmail.text = pessoa.email;
    controllerEstadoCivil.text = pessoa.estadoCivil;
    controllerTipo.text = pessoa.tipo;
    controllerGenero.text = pessoa.genero;
  }

  Future alerta(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Actualização"),
          content: Text("Dados actualizados"),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
