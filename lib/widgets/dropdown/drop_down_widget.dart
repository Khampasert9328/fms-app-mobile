
import 'package:flutter/material.dart';

class DropDownWidgets extends StatelessWidget {
  final String? value;
  final String? hint;
  final void Function(String?)? onChange;
  final List<DropdownMenuItem<String>>? item;
  final FormFieldValidator<String> validator;

  const DropDownWidgets(
      {Key? key,
      this.value,
      this.hint,
      this.onChange,
      this.item,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.red, width: 1))),
      isExpanded: true,
      hint: Text(hint!,
          style: const TextStyle(
              fontFamily: 'NotoSan', overflow: TextOverflow.ellipsis)),
      style: const TextStyle(
          color: Colors.black, fontSize: 16.0, fontFamily: 'NotoSan'),
      items: item,
      value: value,
      onChanged: onChange,
    );
  }
}
