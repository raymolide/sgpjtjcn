import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/process.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/textfield.dart';
import '../widgets/drawer.dart';

class CreateProcess extends StatefulWidget {
  const CreateProcess({Key? key}) : super(key: key);
  @override
  State<CreateProcess> createState() => _CreateProcessState();
}

class _CreateProcessState extends State<CreateProcess> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerNProcesso = TextEditingController();
  TextEditingController controllerRequerido = TextEditingController();
  TextEditingController controllerDataEntrada = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerAreaActuacao = TextEditingController();
  TextEditingController controllerRequerente = TextEditingController();
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerParecer = TextEditingController();
  TextEditingController controllerJuiz = TextEditingController();
  TextEditingController controllerSeccao = TextEditingController();
  TextEditingController controllerAdvogadoRequerido = TextEditingController();
  TextEditingController controllerAdvogadoRequerente = TextEditingController();
  TextEditingController controllerEmailRequerido = TextEditingController();
  TextEditingController controllerEmailRequerente = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();

  var area = ['Processo Civil', 'Processo Penal'];
  String areaActuacao = "Processo Civil";
  var tiposProcesso = [
    'Querela',
    'Policia Correncional',
    'Sumário',
    "Transgressão"
  ];
  String tipoProcesso = "Querela";

  @override
  void initState() {
    clearFields();

    super.initState();
  }

  void clearFields() {
    controllerNProcesso.text = "";
    controllerRequerido.text = "";
    controllerDataEntrada.text = "";
    controllerTipo.text = "";
    controllerAreaActuacao.text = "";
    controllerRequerente.text = "";
    controllerTitulo.text = "";
    controllerParecer.text = "";
    controllerJuiz.text = "";
    controllerSeccao.text = "";
    controllerAdvogadoRequerido.text = "";
    controllerAdvogadoRequerente.text = "";
    controllerEstado.text = "";
    controllerEmailRequerido.text = "";
    controllerEmailRequerente.text = "";
  }

  Process criarProcesso() {
    return Process(
        controllerNProcesso.text,
        controllerEstado.text,
        DateTime.now().toString(),
        controllerTipo.text,
        controllerAreaActuacao.text,
        controllerRequerido.text,
        controllerRequerente.text,
        controllerTitulo.text,
        controllerParecer.text,
        controllerJuiz.text,
        controllerSeccao.text,
        controllerAdvogadoRequerido.text,
        controllerAdvogadoRequerente.text,
        controllerEmailRequerente.text,
        controllerEmailRequerido.text,
        "0");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:
            AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
        drawer: MyDrawer(),
        body: Container(
          height: size.height - AppBar().preferredSize.height,
          color: secundaria,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                shadowColor: secundaria,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * .15,
                              child: textField('NProcesso',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerNProcesso),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField(
                                  'Titulo', Icon(Icons.person, color: primary),
                                  controller: controllerTitulo),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Nome Requerido',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerRequerido),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField('Nome Requerente',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerRequerente),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Advogado Requerido',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerAdvogadoRequerido),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField('Advogado Requerente',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerAdvogadoRequerente),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField(
                                  'Secção', Icon(Icons.person, color: primary),
                                  controller: controllerSeccao),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField('Nome Juiz',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerJuiz),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField('Data Entrada',
                                  Icon(Icons.person, color: primary),
                                  controller: controllerDataEntrada),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: textField(
                                  'Estado', Icon(Icons.person, color: primary),
                                  controller: controllerEstado),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Tipo de Processo",
                                  style: TextStyle(color: primary),
                                ),
                                trailing: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, right: 14),
                                      child: DropdownButton(
                                        hint: Text("Tipo de Processo"),
                                        style:
                                            Theme.of(context).textTheme.button,
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        value: tipoProcesso,
                                        items:
                                            tiposProcesso.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            tipoProcesso = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .01),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Area de Actuação",
                                  style: TextStyle(color: primary),
                                ),
                                trailing: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, right: 14),
                                      child: DropdownButton(
                                        hint: Text("Tipo de Processo"),
                                        style:
                                            Theme.of(context).textTheme.button,
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        value: areaActuacao,
                                        items: area.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            areaActuacao = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textField(
                                  'Parecer', Icon(Icons.person, color: primary),
                                  controller: controllerParecer),
                            ),
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
                                    Icons.list_alt_outlined,
                                    color: Colors.white,
                                  ), () {
                                Navigator.pushNamed(context, '/');
                              }, splashColor: Colors.blue),
                              circleBtn(
                                  const Icon(Icons.delete, color: Colors.white),
                                  () {
                                clearFields();
                              }, splashColor: Colors.red),
                              circleBtnForm(
                                  const Icon(Icons.save, color: Colors.white),
                                  () async {
                                Provider.of<ProcessRepository>(context,
                                        listen: false)
                                    .addProcess(criarProcesso());

                                Map<String, dynamic> mapProcess =
                                    criarProcesso().toMap();

                                final processRef = FirebaseFirestore.instance
                                    .collection('process')
                                    .doc();
                                await processRef.set(mapProcess);
                              }, _formKey, splashColor: Colors.green)
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
        ));
  }
}
