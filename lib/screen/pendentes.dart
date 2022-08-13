// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/process.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:sgpjtjcn/widgets/tableData.dart';

class Pendentes extends StatefulWidget {
  const Pendentes({Key? key}) : super(key: key);

  @override
  State<Pendentes> createState() => _PendentesState();
}

class _PendentesState extends State<Pendentes> {
  late Future<List<Process>> fetchData;
  @override
  void initState() {
    fetchData =
        Provider.of<ProcessRepository>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:
            AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
        drawer: MyDrawer(),
        body: FutureBuilder<List<Process>>(
            future: fetchData,
            initialData: [],
            builder: (context, snapshot) {
              while (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Carregando...")
                  ],
                ));
              }
              return SafeArea(
                  child: Container(
                      color: secundaria,
                      height: size.height - AppBar().preferredSize.height,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.black,
                                    child: Column(
                                      children: [
                                        TableData(),
                                        SizedBox(height: size.height * .02),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  circleBtn(
                                                      Icon(Icons.create,
                                                          color: secundaria),
                                                      () {
                                                    Navigator.pushNamed(
                                                        context, '/process');
                                                  }, splashColor: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )));
            }));
  }
}
