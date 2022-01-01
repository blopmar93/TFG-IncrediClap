import 'package:flutter/material.dart';

class TextButtonAuth extends StatelessWidget {
  
  const TextButtonAuth({
    Key? key, 
    required this.text,
    required this.ruta,
  }) : super(key: key);

  final String text;
  final String ruta;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, ruta), 
      child: Text( text, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black87 ) ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all( const Color.fromRGBO(185, 226, 140, 0.3)),
        shape: MaterialStateProperty.all( const StadiumBorder() )
      ),
    );
  }
}