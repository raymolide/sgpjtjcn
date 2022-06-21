import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primary,
        actions: [appBarActions(context)],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
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
                                      Icon(Icons.create, color: secundaria),
                                      () {
                                    Navigator.pushNamed(context, '/process');
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
      )),
    );
  }
}
