import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:countup/countup.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Map<String, double> mapCivil = {
    "Concluídos": 60,
    "Pendentes": 5,
    "Parados": 7,
  };
  Map<String, double> mapPenal = {
    "Concluídos": 34,
    "Pendentes": 9,
    "Parados": 6,
  };

  List<Color> colorList = [
    Colors.green,
    Colors.yellow,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:
            AppBar(backgroundColor: primary, actions: [appBarActions(context)]),
        drawer: MyDrawer(),
        body: SafeArea(
            child: Container(
                color: secundaria,
                height: size.height - AppBar().preferredSize.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: primary,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 100,
                                  width: 450,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("PROCESSOS",
                                          style: GoogleFonts.alike(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      numberCard(
                                          94,
                                          "Concluídos",
                                          Icon(
                                            Icons.done_all_outlined,
                                            color: Colors.white,
                                          ),
                                          Colors.green),
                                      numberCard(
                                          14,
                                          "Pendentes",
                                          Icon(
                                            Icons.pending,
                                            color: Colors.white,
                                          ),
                                          Colors.yellow),
                                      numberCard(
                                          13,
                                          "Parados",
                                          Icon(
                                            Icons.back_hand_sharp,
                                            color: Colors.white,
                                          ),
                                          Colors.red),
                                      numberCard(
                                          121,
                                          "Total",
                                          Icon(
                                            Icons.archive_rounded,
                                            color: Colors.white,
                                          ),
                                          Colors.blue),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: primary,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 350,
                                  width: 450,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text("PROCESSO CIVIL",
                                            style: GoogleFonts.alike(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Expanded(
                                            child: PieChart(
                                          dataMap: mapCivil,
                                          colorList: colorList,
                                          animationDuration:
                                              Duration(milliseconds: 2000),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: primary,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 350,
                                  width: 450,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text("PROCESSO PENAL",
                                            style: GoogleFonts.alike(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Expanded(
                                            child: PieChart(
                                          dataMap: mapPenal,
                                          colorList: colorList,
                                          animationDuration:
                                              Duration(milliseconds: 2000),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ))));
  }

  Widget numberCard(int total, String label, Icon icon, Color color) {
    return Card(
      elevation: 3,
      child: SizedBox(
        height: 70,
        width: 150,
        child: Container(
          color: color,
          child: ListTile(
            leading: icon,
            title: Countup(
              begin: 0,
              end: double.parse(total.toString()),
              duration: Duration(seconds: 2),
              separator: ',',
              style: GoogleFonts.alike(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 26),
            ),
            subtitle: Text(
              label,
              style: GoogleFonts.alike(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
