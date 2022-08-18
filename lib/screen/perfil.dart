import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/appBar.dart';
import 'package:sgpjtjcn/widgets/drawer.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: size.width * .4,
              height: size.height,
              child: Image.asset('assets/bg.png', fit: BoxFit.fill),
            ),
            Container(
                height: size.height,
                width: size.width * 0.6,
                color: secundaria,
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Text("Perfil",
                              style: GoogleFonts.montserrat(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          MySettings(),
                        ],
                      ))),
                )),
          ],
        ),
      ),
    );
  }
}
