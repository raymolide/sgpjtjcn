import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/model/requerimento.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:sgpjtjcn/widgets/tableDataReq.dart';

class Entradas extends StatefulWidget {
  const Entradas({Key? key}) : super(key: key);

  @override
  State<Entradas> createState() => _EntradasState();
}

class _EntradasState extends State<Entradas> {
  late Future<List<Requerimento>> fetchData;

  @override
  void initState() {
    fetchData =
        Provider.of<RequerimentoRepository>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:
            AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
        drawer: MyDrawer(),
        body: FutureBuilder<List<Requerimento>>(
            initialData: [],
            future: fetchData,
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
                                        TableDataReq(),
                                        SizedBox(height: size.height * .02),
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
