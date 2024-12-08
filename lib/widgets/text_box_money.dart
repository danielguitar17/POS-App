// ignore_for_file: must_be_immutable

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TextBoxMoney extends StatefulWidget {
  void Function(String) funcion;
  String? placeholder;
  String? Function(String?)? funcionValidate;
  String etiqueta;
  IconData icono;
  TextBoxMoney(
      {super.key,
      this.funcionValidate,
      this.placeholder,
      required this.funcion,
      required this.etiqueta,
      required this.icono});

  @override
  State<TextBoxMoney> createState() => _TextBoxMontoState();
}

class _TextBoxMontoState extends State<TextBoxMoney> {
  validator(value) {
    if (value == "") {
      return 'Este Campo es requerido';
    }
    return null;
  }

  final _focusNode4 = FocusNode();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _focusNode4.addListener(() {
      if (!_focusNode4.hasFocus) {
        // Lógica que se ejecutará cuando el usuario salga del campo de texto
        if (controller4.text.isNotEmpty) {
          NumberFormat f = NumberFormat("#,##0.00", "es_AR");
          var a = controller4.text;
          try {
            var b = double.parse(a);
            controller4.text = f.format(b);
          } catch (e) {
            print(e);
          }
        }
      } else {
        controller4.text = "";
      }
    });
    return TextFormBox(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (widget.funcionValidate != null)
          ? widget.funcionValidate
          : (value) {
              if (value == "") {
                return 'Este Campo es requerido';
              }
              return null;
            },

      controller: controller4,
      focusNode: _focusNode4,
      onChanged: widget.funcion,

      placeholder: widget.etiqueta,

      prefix: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(
          FluentIcons.money,
        ),
      ),
      // decoration: BoxDecoration(
      //     border: Border.all(color: secondColor, width: 1),
      //     borderRadius: BorderRadius.circular(10)),
    );
  }
}
