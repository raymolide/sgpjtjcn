import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/model/requerimento.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:sgpjtjcn/widgets/textField.dart';

class ViewRequerimento extends StatefulWidget {
  final String nRequerimento;
  ViewRequerimento({Key? key, required this.nRequerimento}) : super(key: key);

  @override
  State<ViewRequerimento> createState() => _ViewRequerimentoState();
}

class _ViewRequerimentoState extends State<ViewRequerimento> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerRequerimento = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerMotivo = TextEditingController();

  late Future<List<Requerimento>> fetchData;
  int codigo = 1;
  late Requerimento req;

  @override
  void initState() {
    fetchData =
        Provider.of<RequerimentoRepository>(context, listen: false).getData();
    Provider.of<ProcessRepository>(context, listen: false).getData();
    Provider.of<RequerimentoRepository>(context, listen: false).getData();
    super.initState();
  }

  bool isFuncionario = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PersonRepository repository =
        Provider.of<PersonRepository>(context, listen: false);
    return Scaffold(
      appBar:
          AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Requerimento>>(
          future: fetchData,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data!.isNotEmpty) {
                List<Requerimento> requerimentos = snapshot.data!;
                requerimentos.sort(((a, b) => int.parse(a.nRequerimento)
                    .compareTo(int.parse(b.nRequerimento))));

                codigo = int.parse(requerimentos.last.nRequerimento) + 1;

                req = requerimentos
                    .where((element) =>
                        element.nRequerimento == widget.nRequerimento)
                    .first;

                controllerCodigo.text = req.nRequerimento;
                controllerEstado.text =
                    (req.estado != null) ? req.estado : "Pendente";
                controllerMotivo.text = req.motivo;
                controllerRequerimento.text = req.corpo;
              }
              return SafeArea(
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
                                  height: size.height -
                                      AppBar().preferredSize.height,
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
                                                child: IgnorePointer(
                                                  child: textFieldFormParecer(
                                                      'Motivo',
                                                      Icon(Icons.person,
                                                          color: primary),
                                                      controller:
                                                          controllerMotivo),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: IgnorePointer(
                                                  child: textFieldFormParecer(
                                                      'Requerimento',
                                                      Icon(Icons.assignment,
                                                          color: primary),
                                                      controller:
                                                          controllerRequerimento,
                                                      linhas: 7),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 25.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                circleBtn(
                                                    const Icon(
                                                      Icons.back_hand,
                                                      color: Colors.white,
                                                    ), () {
                                                  req.estado = "Indeferido";
                                                  final reqRef =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'requerimento')
                                                          .doc(
                                                              req.nRequerimento)
                                                          .update(req.toMap());
                                                },
                                                    label: "Parar",
                                                    splashColor: Colors.blue),
                                                circleBtnForm(
                                                    const Icon(Icons.send,
                                                        color: Colors.white),
                                                    () async {
                                                  req.estado = "Deferido";
                                                  final reqRef =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'requerimento')
                                                          .doc(
                                                              req.nRequerimento)
                                                          .update(req.toMap());
                                                  Navigator.popAndPushNamed(
                                                      context, '/entradas');
                                                }, _formKey,
                                                    splashColor: Colors.green)
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
                      )));
            }
          }),
    );
  }

  String buscarNomeCompleto(String email, List<Person> pessoas) {
    String nomeCompleto = "";
    if (pessoas.any((element) => element.email == email)) {
      Person pessoa = pessoas.where((element) => element.email == email).first;
      nomeCompleto = pessoa.nome + " " + pessoa.apelido;
    }
    return nomeCompleto;
  }

  Future alerta(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Requerimento"),
          content: Text("Requerimento enviado com sucesso"),
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
