import 'package:flutter/material.dart';
import 'package:sgpjtjcn/util/constants.dart';

Widget ddl(
    BuildContext context, String valor, List<String> items, String label) {
  return Expanded(
    child: ListTile(
      title: Text(
        label,
        style: TextStyle(color: primary),
      ),
      trailing: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: DropdownButton(
              hint: Text(label),
              style: Theme.of(context).textTheme.button,
              alignment: AlignmentDirectional.bottomEnd,
              icon: const Icon(Icons.keyboard_arrow_down),
              value: valor,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {},
            ),
          ),
        ),
      ),
    ),
  );
}
