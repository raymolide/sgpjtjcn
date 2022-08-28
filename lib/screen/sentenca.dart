import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/audiencia.dart';
import 'package:sgpjtjcn/model/sentenca.dart';
import 'package:sgpjtjcn/repository/audiencia_repository.dart';
import 'package:sgpjtjcn/repository/sentenca_repository.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/textfield.dart';

class SentencaScreen extends StatefulWidget {
  String titulo;
  String codProcesso;
  String requerido;
  String requerente;
  String emailRequerido;
  String emailRequerente;

  SentencaScreen(
      {Key? key,
      required this.titulo,
      required this.codProcesso,
      required this.requerido,
      required this.emailRequerido,
      required this.requerente,
      required this.emailRequerente})
      : super(key: key);

  @override
  State<SentencaScreen> createState() => _AudienciaScreenState();
}

class _AudienciaScreenState extends State<SentencaScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerCodProcess = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerRequerido = TextEditingController();
  TextEditingController controllerEmailRequerido = TextEditingController();
  TextEditingController controllerRequerente = TextEditingController();
  TextEditingController controllerEmailRequerente = TextEditingController();
  TextEditingController controlleEstado = TextEditingController();
  TextEditingController controllerParecer = TextEditingController();

  late Future<List<Sentenca>> fetchData;
  int codigo = 1;

  @override
  void initState() {
    fetchData =
        Provider.of<SentencaRepository>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder<List<Sentenca>>(
            initialData: [],
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isNotEmpty) {
                  List<Sentenca> audiencias = snapshot.data!;
                  audiencias.sort(((a, b) =>
                      int.parse(a.codigo).compareTo(int.parse(b.codigo))));

                  codigo = int.parse(audiencias.last.codigo) + 1;
                }

                controllerCodigo.text = codigo.toString();
                preencherDadosProcesso();

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textField(
                                    "Codigo", const Icon(Icons.key),
                                    controller: controllerCodigo),
                              ),
                              SizedBox(height: size.height * .02),
                              Expanded(
                                child: textField(
                                    "CodProcesso", const Icon(Icons.home),
                                    controller: controllerCodProcess),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textField(
                                    "Titulo", const Icon(Icons.chair_alt),
                                    controller: controllerTitulo),
                              ),
                              SizedBox(height: size.height * .02),
                              Expanded(
                                child: textField(
                                    "Estado", Icon(Icons.date_range),
                                    controller: controlleEstado),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textField("Data", Icon(Icons.chair_alt),
                                    controller: controllerData),
                              ),
                              SizedBox(height: size.height * .02),
                              Expanded(
                                child: textField(
                                    "Parecer", Icon(Icons.date_range),
                                    controller: controllerParecer),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textField(
                                    "Requerido", Icon(Icons.chair_alt),
                                    controller: controllerRequerido),
                              ),
                              SizedBox(height: size.height * .02),
                              Expanded(
                                child: textField(
                                    "Email Requerido", Icon(Icons.date_range),
                                    controller: controllerEmailRequerido),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textField(
                                    "Requerente", Icon(Icons.chair_alt),
                                    controller: controllerRequerente),
                              ),
                              SizedBox(height: size.height * .02),
                              Expanded(
                                child: textField(
                                    "Email Requerente", Icon(Icons.date_range),
                                    controller: controllerEmailRequerente),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  circleBtn(
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ), () {
                                    Sentenca audiencia = Sentenca(
                                        codigo: controllerCodigo.text,
                                        codProcesso: controllerCodProcess.text,
                                        data: controllerData.text,
                                        tituloProcesso: controllerTitulo.text,
                                        estado: controlleEstado.text,
                                        parecer: controllerParecer.text,
                                        requerente: controllerRequerente.text,
                                        emailRequerente:
                                            controllerEmailRequerente.text,
                                        requerido: controllerRequerido.text,
                                        emailRequerido:
                                            controllerEmailRequerido.text);

                                    final reqRef = FirebaseFirestore.instance
                                        .collection('sentenca')
                                        .doc(audiencia.codigo)
                                        .set(audiencia.toMap());
                                    Navigator.popAndPushNamed(
                                        context, '/pending');
                                  }),
                                  Text("Sentença")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }));
  }

  void preencherDadosProcesso() {
    controllerCodProcess.text = widget.codProcesso;
    controllerTitulo.text = widget.titulo;
    controllerRequerido.text = widget.requerido;
    controllerEmailRequerido.text = widget.emailRequerido;
    controllerRequerido.text = widget.requerente;
    controllerEmailRequerente.text = widget.emailRequerente;
  }
}
