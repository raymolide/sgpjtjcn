import 'package:flutter/material.dart';
import 'package:sgpjtjcn/util/constants.dart';
import 'package:sgpjtjcn/widgets/button.dart';
import 'package:sgpjtjcn/widgets/textField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            SizedBox(
              height: size.height,
              width: size.width * 0.6,
              child: Image.asset('assets/bg.png', fit: BoxFit.fill),
            ),
            Container(
              width: size.width * .4,
              height: size.height,
              color: secundaria,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TJCN",
                            style: TextStyle(
                                color: primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: size.height * 0.20),
                        textFieldEmail("E-mail do Utilizador",
                            const Icon(Icons.person, color: Colors.white)),
                        SizedBox(height: size.height * 0.02),
                        textFieldPassword("Senha",
                            const Icon(Icons.lock, color: Colors.white)),
                        SizedBox(height: size.height * 0.15),
                        textButton(context, "Login", '/pending', _formKey),
                        SizedBox(height: size.height * 0.03),
                        InkWell(
                          child: Text(
                            "Esqueceu password?",
                            style: TextStyle(color: primary, fontSize: 17),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        InkWell(
                          child: Text(
                            "Criar Conta",
                            style: TextStyle(color: primary, fontSize: 15),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/register");
                          },
                        ),
                        SizedBox(height: size.height * 0.08),
                        Text(
                          "Raimundo Molide",
                          style: TextStyle(color: primary, fontSize: 15),
                        ),
                        Text(
                          "2022",
                          style: TextStyle(color: primary, fontSize: 15),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
