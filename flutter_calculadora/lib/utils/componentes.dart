import 'dart:ui';
import 'package:flutter/material.dart';

class Componentes{

  static formataTexto (tamanho, Color cor, {bool negrito=false, bool italico=false}){
    return TextStyle(
        fontSize: tamanho,
        color: cor,
        fontWeight: negrito?FontWeight.bold:FontWeight.normal,
        fontStyle: italico?FontStyle.italic:FontStyle.normal
    );
  }
  
  static botao (String _texto, Function _f){
    return Container(
      child: RaisedButton(
        onPressed: _f,
        child: Text(_texto,
          style: formataTexto(18, Colors.white),
        ),
      ),
    );
  }

  static caixaDeTexto (String dica, String nome, TextEditingController controlador, {bool obscure=false, bool numero=false, String textoErro='erro'}){
    bool numberInputValid = true;
    return TextField(

      controller: controlador,
      obscureText: obscure,
      keyboardType: numero?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
        labelText: nome,
        labelStyle: TextStyle(fontSize: 18),
        hintText: dica,
        hintStyle: TextStyle(fontSize: 10, color: Colors.black87.withOpacity(0.4)),
        errorText: numberInputValid?null:textoErro,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),

    );
  }
}