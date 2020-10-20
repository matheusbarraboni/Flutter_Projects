import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Componentes{
  static botao(String _texto, Function _f) {
    return Container(
      child: RaisedButton(
        onPressed: _f,
        child: Text(
          _texto,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black, width: 4),
        ),
        color: Colors.black87.withOpacity(0.4),
        hoverColor: Colors.yellow.withOpacity(0.3),
      ),
    );
  }

  static caixaDeTexto(String rotulo, String dica,
      TextEditingController controlador, validacao,
      {bool obscure=false, bool numero=false}){
    return TextFormField(
      controller: controlador,
      obscureText: obscure,
      validator: validacao,
      keyboardType: numero?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: TextStyle(fontSize: 18),
        hintText: dica,
        hintStyle: TextStyle(fontSize: 10, color: Colors.black87.withOpacity(0.4)),

      ),
    );
  }

  static icone(icone, double tamanho, Color cor) {
    return FaIcon(
      icone,
      size: tamanho,
      color: cor,
    );
  }

  var ola = Map();

  static estiloTexto(double _tamanho, bool _negrito, Color _cor) {
    return TextStyle(
      fontSize: _tamanho,
      fontWeight: _negrito?FontWeight.bold:FontWeight.normal,
      color: _cor,
    );
  }

}