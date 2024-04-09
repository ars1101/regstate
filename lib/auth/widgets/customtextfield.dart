import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget{
  final String label;
  final String hint;
  final bool obs;
  final TextEditingController ctr;
  final Function(String)? onChanged;
  final Function()? onTapSuffix;
  final MaskTextInputFormatter? formatter;

  CustomTextField({required this.label, required this.hint, required this.obs, required this.ctr, this.formatter, this.onTapSuffix, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFAF0),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start
          ,children: [Text(label,style: Theme.of(context).textTheme.titleSmall,),
            SizedBox(height: 8,),
            SizedBox(width: MediaQuery.of(context).size.width - 48,height: 44,child:
            TextField(
                inputFormatters: (formatter != null) ? [formatter!] : [],
                style: TextStyle(
                color: Color(0xFF3A3A3A),
                fontSize: 14,
                fontWeight: FontWeight.w500, ),  obscuringCharacter: "*", controller: ctr, onChanged: onChanged, obscureText: obs,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)), contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10), hintText: hint,
                  suffixIcon: (onTapSuffix != null)
                      ? SizedBox(height: 15, width: 15,
                    child: GestureDetector(
                      onTap: onTapSuffix,
                      child: Image.asset("assets/eye-slash.png"),
                    ),
                  )
                      : null,
                  focusColor: Color.fromARGB(255, 167, 167, 167),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA7A7A7))
                  ),


                )
            )
              ,)

          ],)
    );
  }
}








