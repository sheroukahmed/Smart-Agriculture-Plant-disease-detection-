import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.green,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}













class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  //final double height;
  final double borderRadius;
  final double elevation;

  const CustomMaterialButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.lightGreen,
    this.width = double.infinity,
    this.borderRadius = 18.0,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      //height: height,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.lightGreen.shade800,
        elevation: elevation,
        child: Text(
          text.toUpperCase(),
        style: TextStyle(
              color: Colors.white),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        ),


    );
  }
}










class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String labelText;

  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final Color? focusColor;


  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.labelText,
    this.onFieldSubmitted,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.focusColor,

    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,

      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.lightGreen), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.lightGreen), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),

      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
  }

}

class ClickableIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ClickableIcon({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon),
    );
  }
}
