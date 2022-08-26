// ignore_for_file: unnecessary_cast, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/person.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/util/constants.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Future<List<Person>> fetchData;

  @override
  void initState() {
    fetchData = Provider.of<PersonRepository>(context, listen: false).getData();
    Provider.of<ProcessRepository>(context, listen: false).getData();
    Provider.of<RequerimentoRepository>(context, listen: false).getData();
    super.initState();
  }

  bool isFuncionario = true;

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<PersonRepository>(context, listen: false).email;

    return Container(
      child: Drawer(
        backgroundColor: secundaria,
        child: FutureBuilder<List<Person>>(
            initialData: [],
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isNotEmpty) {
                  Person pessoa = snapshot.data!
                      .where((element) => element.email == email)
                      .first;
                  if (pessoa.tipo.toLowerCase() == "parte") {
                    isFuncionario = false;
                  } else {
                    isFuncionario = true;
                  }
                }
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFFc75b39),
                      ),
                      child: Center(
                        child: ListTile(
                          leading:
                              Icon(Icons.person, size: 50, color: Colors.white),
                          title: Text(
                            "",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                            email,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      )),
                  !isFuncionario
                      ? ListTile(
                          title: const Text(
                            'Requerer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/requerer');
                          },
                        )
                      : Container(),
                  isFuncionario
                      ? ListTile(
                          title: const Text(
                            'Entradas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/entradas');
                          },
                        )
                      : Container(),
                  !isFuncionario
                      ? ListTile(
                          title: const Text(
                            'Minhas Entradas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/entradas');
                          },
                        )
                      : Container(),
                  !isFuncionario
                      ? ListTile(
                          title: const Text(
                            'Meus Processos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/pending');
                          },
                        )
                      : ListTile(
                          title: const Text(
                            'Processos Pendentes',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/pending');
                          },
                        ),
                  !isFuncionario
                      ? ListTile(
                          title: const Text(
                            'Minhas Audiencias',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/audiencias');
                          },
                        )
                      : Container(),
                  isFuncionario
                      ? ListTile(
                          title: const Text('Criar Processos',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/process');
                          },
                        )
                      : Container(),
                  isFuncionario
                      ? ListTile(
                          title: const Text('Relatário',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/report');
                          },
                        )
                      : Container(),
                  ListTile(
                    title: const Text('Conta',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    hoverColor: primary,
                    onTap: () => showDialog<String>(
                      barrierColor: secundaria,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Perfil'),
                              InkWell(
                                child: Icon(
                                  Icons.close_rounded,
                                  color: primary,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                          content: MySettings()),
                    ),
                  ),
                  isFuncionario
                      ? ListTile(
                          title: const Text('Painel Adminstrador',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          hoverColor: primary,
                          onTap: () {
                            Navigator.pushNamed(context, '/paneladmin');
                          },
                        )
                      : Container(),
                  ListTile(
                    title: const Text('Sair',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
