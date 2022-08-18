import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/firebase_options.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/repository/requerimento_repository.dart';
import 'package:sgpjtjcn/screen/create_process.dart';
import 'package:sgpjtjcn/screen/entradas.dart';
import 'package:sgpjtjcn/screen/login.dart';
import 'package:sgpjtjcn/screen/pendentes.dart';
import 'package:sgpjtjcn/screen/perfil.dart';
import 'package:sgpjtjcn/screen/register.dart';
import 'package:sgpjtjcn/screen/report.dart';
import 'package:sgpjtjcn/screen/requerer.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/screen/view_process.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ProcessRepository())),
        ChangeNotifierProvider(create: ((context) => PersonRepository())),
        ChangeNotifierProvider(create: ((context) => RequerimentoRepository()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/login': (context) => const Login(),
            '/register': (context) => const Register(),
            '/requerer': (context) => Requerer(),
            '/pending': (context) => const Pendentes(),
            '/viewProcess': (context) => ViewProcess(nprocesso: ''),
            '/settings': (context) => MySettings(),
            '/process': (context) => const CreateProcess(),
            '/report': (context) => Report(),
            '/entradas': (context) => Entradas(),
            '/perfil': (context) => Perfil(),
          },
          home: Login())));
}
