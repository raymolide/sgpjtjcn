import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/process.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:sgpjtjcn/widgets/dropdown.dart';
import 'package:sgpjtjcn/widgets/textfield.dart';

class ViewProcess extends StatefulWidget {
  String nprocesso;
  ViewProcess({Key? key, required this.nprocesso}) : super(key: key);

  @override
  State<ViewProcess> createState() => _ViewProcessState();
}

class _ViewProcessState extends State<ViewProcess> {
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
    if (widget.nprocesso.isNotEmpty) {
      ProcessRepository processData =
          Provider.of<ProcessRepository>(context, listen: false);
      DateFormat formater = DateFormat('dd-MM-yyyy');
      Process processo = processData.getProcess(widget.nprocesso);
      controllerNProcesso.text = processo.nprocess;
      controllerRequerido.text = processo.requerido;
      controllerDataEntrada.text = formater.format(processo.dataInicio);
      controllerTipo.text = processo.tipo;
      controllerAreaActuacao.text = processo.areaAtuacao;
      controllerRequerente.text = processo.requerente;
      controllerTitulo.text = processo.titulo;
      controllerParecer.text = processo.parecer;
      controllerJuiz.text = processo.juiz;
      controllerSeccao.text = processo.seccao;
      controllerAdvogadoRequerido.text = processo.advogadoRequerido;
      controllerAdvogadoRequerente.text = processo.advogadoRequerente;
      controllerEstado.text = processo.estado;
    } else {
      clearFields();
    }

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
  }

  Process criarProcesso() {
    return Process(
        controllerNProcesso.text,
        controllerEstado.text,
        //DateTime.parse(controllerDataEntrada.text),
        DateTime.now(),
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
        0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: size.height - AppBar().preferredSize.height,
          color: secundaria,
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                            ddl(context, tipoProcesso, tiposProcesso,
                                "Tipo de Processo"),
                            SizedBox(width: size.width * .01),
                            ddl(context, areaActuacao, area, "Area de Actuação")
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: textFieldFormParecer(
                                  'Parecer', Icon(Icons.person, color: primary),
                                  controller: controllerParecer, linhas: 3),
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
                              circleBtn(
                                  const Icon(Icons.save, color: Colors.white),
                                  () {
                                bool existe = Provider.of<ProcessRepository>(
                                        context,
                                        listen: false)
                                    .isExistenteProcess(
                                        controllerNProcesso.text);

                                if (existe) {
                                  Provider.of<ProcessRepository>(context,
                                          listen: false)
                                      .updateProcess(criarProcesso());
                                } else {
                                  Provider.of<ProcessRepository>(context,
                                          listen: false)
                                      .addProcess(criarProcesso());
                                }
                              }, splashColor: Colors.green)
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
