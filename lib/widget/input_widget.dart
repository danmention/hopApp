import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final double height;
  final String topLabel;
  final bool obscureText;
  final bool? inputType;
  final int?  maxLines;
  final TextInputType?  keyboardInputType;
  final TextEditingController?  textEditingController;
final Function(String?)? onsaved;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.inputType,
    this.maxLines,
    this.keyboardInputType,
    this.textEditingController,
    this.onsaved,


  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel),
        SizedBox(height: 5.0),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child:

          TextFormField(
            controller:textEditingController ,
               onSaved: onsaved,
               keyboardType: this.keyboardInputType,
            maxLines: maxLines??1,
            obscureText: this.obscureText,
            decoration: InputDecoration(
              // prefixIcon: prefixIcon == null ? prefixIcon : Icon(prefixIcon,
              //   color: Color.fromRGBO(105, 108, 121, 1),
              // ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                ),
              ),
              hintText: this.hintText,

              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}