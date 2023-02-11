import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  final String hintText;
  final List<String> listOfValue;
  final String? selectedValue;
  //final String Function(T)? getLabel;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;

  InputDropdown({
    this.hintText = 'Please select an Option',
    this.listOfValue = const [],

    this.selectedValue,
    this.onChanged,
    this.onSaved
  });


  //String? _selectedValue;
 // List<String> listOfValue = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return

      DropdownButtonFormField(
        value: selectedValue,
        hint: Text(
          'choose one',
        ),
        isExpanded: true,
        onChanged:onChanged ,
        onSaved:onSaved,

        validator: (String? value) {
          if (value!.isEmpty) {
            return "can't empty";
          } else {
            return null;
          }
        },
        items: listOfValue
            .map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      );

    //   FormField<T>(
    //   builder: (FormFieldState<T> state) {
    //     return InputDecorator(
    //       decoration: InputDecoration(
    //         contentPadding: EdgeInsets.symmetric(
    //             horizontal: 20.0, vertical: 15.0),
    //         labelText: hintText,
    //         border:
    //         OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    //       ),
    //       isEmpty: value == null || value == '',
    //       child: DropdownButtonHideUnderline(
    //         child: DropdownButton<T>(
    //           value: value,
    //           isDense: true,
    //           onChanged: onChanged,
    //           items: options.map((T value) {
    //             return DropdownMenuItem<T>(
    //               value: value,
    //               child: Text(getLabel!(value)),
    //             );
    //           }).toList(),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}