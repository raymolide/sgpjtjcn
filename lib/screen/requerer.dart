import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/model/requerimento.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
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
  int codigo = 1;
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerRequerimento = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerMotivo = TextEditingController();

  late Future<List<Requerimento>> fetchData;

  @override
  void initState() {
    fetchData =
        Provider.of<RequerimentoRepository>(context, listen: false).getData();
    controllerEstado.text = "Enviado";
    super.initState();
  }

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
                List<Requerimento> codigos = snapshot.data!;
                codigos.sort(((a, b) => int.parse(a.nRequerimento)
                    .compareTo(int.parse(b.nRequerimento))));

                codigo = int.parse(codigos.last.nRequerimento) + 1;
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
                                                child: textFieldFormParecer(
                                                    'Motivo',
                                                    Icon(Icons.person,
                                                        color: primary),
                                                    controller:
                                                        controllerMotivo),
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
                                                    controller:
                                                        controllerRequerimento,
                                                    linhas: 7),
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
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                    () {},
                                                    splashColor: Colors.blue),
                                                circleBtnForm(
                                                    const Icon(Icons.send,
                                                        color: Colors.white),
                                                    () async {
                                                  Requerimento req = Requerimento(
                                                      nRequerimento: "$codigo",
                                                      motivo:
                                                          controllerMotivo.text,
                                                      corpo:
                                                          controllerRequerimento
                                                              .text,
                                                      estado:
                                                          controllerEstado.text,
                                                      email: repository.email,
                                                      nome: buscarNomeCompleto(
                                                          repository.email,
                                                          repository.pessoas));
                                                  print(
                                                      "email: ${repository.email}, nome: ${buscarNomeCompleto(repository.email, repository.pessoas)}");

                                                  Provider.of<RequerimentoRepository>(
                                                          context,
                                                          listen: false)
                                                      .addRequerimento(req);

                                                  Map<String, dynamic> mapReq =
                                                      req.toMap();

                                                  final reqRef =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'requerimento')
                                                          .doc();
                                                  await reqRef.set(mapReq);
                                                  Navigator.popAndPushNamed(
                                                      context, '/requerer');
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
}
