import 'package:flutter_calculadora/utils/componentes.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController controller1 =TextEditingController();
  TextEditingController controller2 =TextEditingController();
  TextEditingController controller3 =TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: telaPrincipal(),
    );
  }

  criaPaginaInicial() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter', style: Componentes.formataTexto(20, Colors.white, negrito: true),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: limpaTela,
          )
        ],
      ),
      body: criaCalculadora(),
    );
  }

  criaCalculadora() {
    return Form(
        key: cForm,
        child: Container(
          width: 200,
          child: Column(
            children: [
              Componentes.caixaDeTexto('Digite o primeiro número', '1° número', controller1, numero: true),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.add, color: Colors.blue,),
                    tooltip: 'Somar',
                    onPressed: soma,
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.remove, color: Colors.blue,),
                    tooltip: 'Subtrair',
                    onPressed: sub,
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.clear, color: Colors.blue,),
                    tooltip: 'Multiplicar',
                    onPressed: multi,
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.strikethrough_s, color: Colors.blue,),
                    tooltip: 'Dividir',
                    onPressed: div,
                  ),
                ],
              ),
              Text(resultado, style: Componentes.formataTexto(30, Colors.black),),
            ],
          ),
        ),
    );
  }

  soma (){
    setState(() {
      if (!cForm.currentState.validate()){
        return null;
      }
      double num1 = double.parse(controller1.text);
      double num2 = double.parse(controller2.text);
      resultado = 'A soma vale: ${num1 + num2}';
    });
  }

  sub (){
    setState(() {
      if (!cForm.currentState.validate()){
        return null;
      }
      double num1 = double.parse(controller1.text);
      double num2 = double.parse(controller2.text);
      resultado = 'A subtração vale: ${num1 - num2}';
    });
  }

  multi (){
    setState(() {
      if (!cForm.currentState.validate()){
        return null;
      }
      double num1 = double.parse(controller1.text);
      double num2 = double.parse(controller2.text);
      resultado = 'A multiplicação vale: ${num1 * num2}';
    });
  }

  div (){
    setState(() {
      if (!cForm.currentState.validate()){
        return null;
      }
      double num1 = double.parse(controller1.text);
      double num2 = double.parse(controller2.text);
      resultado = 'A divisão vale: ${num1 / num2}';
    });
  }

  Function validaCampo = ((value){
    if (value.isEmpty){
      return 'Informe algum valor';
    }
    return null;
  });

  limpaTela (){
    controller1.text = '';
    controller2.text = '';
    setState(() {
      resultado = '';
      cForm = GlobalKey<FormState>();
    });
  }

  Widget caixaTexto (){
    return Container(
      width: 200,
      child: Componentes.caixaDeTexto('numero', 'teste', controller3),
    );
  }

  telaPrincipal (){
    return Container(
      child: Container(
        child: Column(
          children: [
            Text('Primeiro número'),
            caixaTexto(),
          ],
        ),
      ),
    );
  }

}
