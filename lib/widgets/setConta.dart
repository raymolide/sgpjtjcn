import 'package:flutter/material.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/util/constants.dart';

class SetConta extends StatefulWidget {
  const SetConta({Key? key}) : super(key: key);

  @override
  State<SetConta> createState() => _SetContaState();
}

class _SetContaState extends State<SetConta> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Perfil'),
            InkWell(
              child: Icon(
                Icons.close_rounded,
                color: primary,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        content: MySettings());
  }
}
