import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgpjtjcn/repository/person_repository.dart';
import 'package:sgpjtjcn/util/constants.dart';

Widget textButton(
    BuildContext context,
    String label,
    String route,
    GlobalKey<FormState> formKey,
    TextEditingController email,
    TextEditingController password,
    String flag) {
  return TextButton(
    child: Text(label, style: const TextStyle(fontSize: 16)),
    style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size.fromWidth(150)),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        foregroundColor: MaterialStateProperty.all<Color>(primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: primary)))),
    onPressed: () async {
      if (formKey.currentState!.validate()) {
        if (flag == 'R') {
          await Provider.of<PersonRepository>(context, listen: false)
              .register(email.text, password.text)
              .then((acesso) async => acesso
                  ? await Navigator.pushNamed(context, route)
                  : alertaError(context));
        }
        if (flag == 'L') {
          await Provider.of<PersonRepository>(context, listen: false)
              .signIn(email.text, password.text)
              .then((acesso) async => acesso
                  ? await Navigator.pushNamed(context, "/pending")
                  : alertaError(context));
        }
      }
    },
  );
}

Future alertaError(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Erro"),
        content: Text("As suas credencias são invalidas"),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}

Widget circleBtnForm(
    Icon icon, void Function() onPressed, GlobalKey<FormState> formKey,
    {String? label, Color? splashColor}) {
  return SizedBox.fromSize(
    size: const Size(46, 46),
    child: ClipOval(
      child: Material(
        color: primary,
        child: InkWell(
          splashColor: splashColor,
          onTap: () {
            if (formKey.currentState!.validate()) {
              onPressed();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon, // <-- Icon
              // <-- Text
            ],
          ),
        ),
      ),
    ),
  );
}

Widget circleBtn(Icon icon, void Function() onPressed,
    {String? label, Color? splashColor}) {
  return SizedBox.fromSize(
    size: const Size(46, 46),
    child: ClipOval(
      child: Material(
        color: primary,
        child: InkWell(
          splashColor: splashColor,
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon, // <-- Icon
              // <-- Text
            ],
          ),
        ),
      ),
    ),
  );
}
