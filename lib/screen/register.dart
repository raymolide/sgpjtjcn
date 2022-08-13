import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/button.dart';

import '../widgets/textfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              color: secundaria,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("TJCN",
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: size.height * 0.1),
                          textFieldEmail("E-mail do Utilizador",
                              Icon(Icons.person, color: secundaria),
                              controller: email),
                          SizedBox(height: size.height * 0.02),
                          textFieldPassword(
                              "Senha", Icon(Icons.lock, color: secundaria),
                              controller: password),
                          SizedBox(height: size.height * 0.02),
                          textFieldPassword("Confirmar Senha",
                              Icon(Icons.lock, color: secundaria),
                              controller: password),
                          SizedBox(height: size.height * 0.1),
                          textButton(context, "Registar", '/login', _formKey,
                              email: email,
                              password: password,
                              condition: Provider.of<PersonRepository>(context,
                                      listen: false)
                                  .register(email.text, password.text)),
                          SizedBox(height: size.height * 0.03),
                          SizedBox(height: size.height * 0.01),
                          InkWell(
                              child: Text(
                                "Possui uma Conta?",
                                style: TextStyle(color: primary, fontSize: 15),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, "/login");
                              }),
                          SizedBox(height: size.height * 0.1),
                          Text(
                            "Raimundo Molide",
                            style: TextStyle(color: primary, fontSize: 15),
                          ),
                          Text(
                            "2022",
                            style: TextStyle(color: primary, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            Container(
              height: size.height,
              width: size.width * 0.6,
              child: Image.asset('assets/bg.png', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
