import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/audiencia.dart';
import 'package:sgpjtjcn/repository/audiencia_repository.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/textfield.dart';

class AudienciaScreen extends StatefulWidget {
  String emailRequerindo;
  String emailRequerente;
  String titulo;
  AudienciaScreen(
      {Key? key,
      required this.titulo,
      required this.emailRequerente,
      required this.emailRequerindo})
      : super(key: key);

  @override
  State<AudienciaScreen> createState() => _AudienciaScreenState();
}

class _AudienciaScreenState extends State<AudienciaScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerSala = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerQtdPessoas = TextEditingController();
  late Future<List<Audiencia>> fetchData;
  int codigo = 1;

  @override
  void initState() {
    fetchData =
        Provider.of<AudienciaRepository>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder<List<Audiencia>>(
            initialData: [],
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isNotEmpty) {
                  List<Audiencia> audiencias = snapshot.data!;
                  audiencias.sort(((a, b) =>
                      int.parse(a.codigo).compareTo(int.parse(b.codigo))));

                  codigo = int.parse(audiencias.last.codigo) + 1;
                }

                controllerCodigo.text = codigo.toString();

                return Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textField("Codigo", Icon(Icons.key),
                                controller: controllerCodigo),
                            SizedBox(height: size.height * .02),
                            textField("Sala", Icon(Icons.home),
                                controller: controllerSala),
                            SizedBox(height: size.height * .02),
                            textField("Número Lugares", Icon(Icons.chair_alt),
                                controller: controllerQtdPessoas),
                            SizedBox(height: size.height * .02),
                            textField("Data", Icon(Icons.date_range),
                                controller: controllerData),
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
                                      Audiencia audiencia = Audiencia(
                                          codigo: controllerCodigo.text,
                                          titulo: widget.titulo,
                                          sala: controllerSala.text,
                                          nrLugares: controllerQtdPessoas.text,
                                          data: controllerData.text,
                                          emailRequerente:
                                              widget.emailRequerente,
                                          emailRequerido:
                                              widget.emailRequerindo);

                                      final reqRef = FirebaseFirestore.instance
                                          .collection('audiencia')
                                          .doc(audiencia.codigo)
                                          .set(audiencia.toMap());
                                      Navigator.popAndPushNamed(
                                          context, '/pending');
                                    }),
                                    Text("Marcar")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
