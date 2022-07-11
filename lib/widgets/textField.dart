import 'package:flutter/material.dart';
import 'package:sgpjtjcn/util/constants.dart';

Widget textField(String label, Icon icon, {TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
        labelText: label,
        fillColor: primary,
        enabled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        hintText: label,
        labelStyle: TextStyle(color: primary),
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: icon,
        suffixStyle: TextStyle(color: primary)),
    onSaved: (String? value) {},
    validator: (String? value) {
      return (value == null || value.trim().isEmpty) ? 'Dado inválido.' : null;
    },
  );
}

Widget textFieldEmail(String label, Icon icon,
    {TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
        filled: true,
        fillColor: primary,
        enabled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        hintText: label,
        labelStyle: TextStyle(color: primary),
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: icon,
        suffixStyle: TextStyle(color: primary)),
    onSaved: (String? value) {},
    validator: (String? value) {
      return (value == null || !value.contains('@')) ? 'Email inválido.' : null;
    },
  );
}

Widget textFieldFormParecer(String label, Icon icon,
    {TextEditingController? controller, linhas}) {
  return TextFormField(
    maxLines: linhas,
    controller: controller,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      label: Text(
        label,
        style: TextStyle(color: primary),
      ),
      labelStyle: TextStyle(color: primary),
      hintText: label,
      hintStyle: const TextStyle(color: Colors.black),
      prefixIcon: icon,
      suffixStyle: TextStyle(color: primary),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary),
      ),
    ),
  );
}

Widget textFieldPassword(String label, Icon icon) {
  return TextFormField(
    //keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    style: const TextStyle(color: Colors.white),
    enabled: true,
    decoration: InputDecoration(
        filled: true,
        fillColor: primary,
        enabled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(60)),
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: icon,
        suffixStyle: TextStyle(color: primary)),
    onSaved: (String? value) {},
    validator: (String? value) {
      return (value == null || value.isEmpty)
          ? 'Palavra-passe inválida.'
          : null;
    },
  );
}
