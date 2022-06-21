import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/repository/process_repository.dart';
import 'package:sgpjtjcn/screen/create_process.dart';
import 'package:sgpjtjcn/screen/login.dart';
import 'package:sgpjtjcn/screen/pendentes.dart';
import 'package:sgpjtjcn/screen/register.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/screen/view_process.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ProcessRepository()))
      ],
      child: MaterialApp(routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/pending': (context) => const Pendentes(),
        '/viewProcess': (context) => ViewProcess(nprocesso: ''),
        '/settings': (context) => MySettings(),
        '/process': (context) => CreateProcess()
      }, home: const Pendentes())));
}
