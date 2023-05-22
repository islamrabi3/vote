import 'package:flutter/material.dart';

var uid = '';

Widget defaultButton({required Function() function, required String text}) {
  return SizedBox(
    width: double.infinity,
    height: 50.0,
    child: ElevatedButton(onPressed: function, child: Text(text)),
  );
}

void navigatetTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndRemove(context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget myDivider() {
  return Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[400],
  );
}

Widget dTextFormField(
    {required TextEditingController controller,
    TextInputType? textinput,
    String? Function(String?)? validate,
    IconData? prefixIcon,
    required String label,
    Function(String)? onsubmit,
    required String hintText,
    IconData? suffixIcon,
    bool? enabled,
    bool? obsecure,
    Color? color}) {
  return TextFormField(
    enabled: enabled,
    controller: controller,
    validator: validate,
    keyboardType: textinput,
    obscureText: obsecure ?? false,
    decoration: InputDecoration(
      suffixIcon: Icon(suffixIcon),
      // enabledBorder: InputBorder.none,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      filled: true,
      fillColor: color,
      hintText: hintText,
      labelText: label,
    ),
    onFieldSubmitted: onsubmit,
  );
}
