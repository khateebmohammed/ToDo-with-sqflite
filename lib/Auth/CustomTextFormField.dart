import 'package:flutter/material.dart';


class CustomTextFormField extends StatefulWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController myController;

  const CustomTextFormField(
      {Key? key,
      required this.hint,
      required this.myController,
      required this.valid})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        validator: widget.valid,
        controller: widget.myController,
        decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1))),
      ),
    );
  }
}
