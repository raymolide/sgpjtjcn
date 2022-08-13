import 'package:flutter/material.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:sgpjtjcn/widgets/textField.dart';

class Requerer extends StatefulWidget {
  Requerer({Key? key}) : super(key: key);

  @override
  State<Requerer> createState() => _RequererState();
}

class _RequererState extends State<Requerer> {
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

  var estadoCivil = ['Solteiro/a', 'Casado/a', "Divorciado/a", "Viuvo/a"];
  String estado = "Solteiro/a";
  var perfils = [
    'Admin',
    'Advogado/a',
    "Requerente",
    "Requerido",
    "Juiz",
    "Escrivão"
  ];
  String perfil = "Escrivão";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:
            AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
        drawer: MyDrawer(),
        body: SafeArea(
            child: Container(
                color: secundaria,
                height: size.height - AppBar().preferredSize.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            height: size.height - AppBar().preferredSize.height,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * .02),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .6,
                                          child: textFieldFormParecer(
                                              'Motivo',
                                              Icon(Icons.person,
                                                  color: primary),
                                              controller: controllerBI),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: textFieldFormParecer(
                                              'Requerimento',
                                              Icon(Icons.assignment,
                                                  color: primary),
                                              controller: controllerGenero,
                                              linhas: 7),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          circleBtn(
                                              const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              () {},
                                              splashColor: Colors.blue),
                                          circleBtnForm(
                                              const Icon(Icons.send,
                                                  color: Colors.white),
                                              () => {},
                                              _formKey,
                                              splashColor: Colors.white)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ))));
  }
}
