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
  Stream<List<Process>> getFromDB() {
    return FirebaseFirestore.instance.collection('process').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Process.fromJsonFire(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference pro = FirebaseFirestore.instance.collection('process');

    return Scaffold(
      appBar:
          AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
      drawer: MyDrawer(),
      body: FutureBuilder(
          future: pro.doc('f1wh6GHrjshWa2LucJOB').get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Occorreu um erro'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  children: [CircularProgressIndicator(), Text("Esperando...")],
                ),
              );
            }

            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              Process processo = Process.fromJsonDB(data);
              Provider.of<ProcessRepository>(context, listen: false)
                  .addProcess(processo);

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
                        child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                TableData(),
                                SizedBox(height: size.height * .02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          circleBtn(
                                              Icon(Icons.create,
                                                  color: secundaria), () {
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
                    ],
                  ),
                ),
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
