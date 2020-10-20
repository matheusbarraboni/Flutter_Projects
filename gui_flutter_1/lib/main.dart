import 'dart:convert';
import 'dart:ui';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gui_flutter_1/utils/componentes.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController controllerWOEID = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  int temp = 0;
  int max = 0;
  int min = 0;
  String vento = '0';
  String condicao = 'none_day';
  String cidade = 'cidade';
  Map previsao = {
    'dia 1' : {
      'max': 0,
      'min': 0,
      'date': 'date'
    },
    'dia 2' : {
      'max': 0,
      'min': 0,
      'date': 'date'
    },
    'dia 3' : {
      'max': 0,
      'min': 0,
      'date': 'date'
    }
  };
  Map icones = {
  'storm': {
    'icone': FontAwesomeIcons.cloudShowersHeavy,
    'txt': 'Tempestade',
    'cor': Colors.grey,
    'cor_icone': Colors.white,
    'cor_texto': Colors.white
  },
  'snow':  {
    'icone': FontAwesomeIcons.snowflake,
    'txt': 'Nevando',
    'cor': Colors.white,
    'cor_icone': Colors.black12,
    'cor_texto': Colors.black
  },
  'rain':  {
    'icone': FontAwesomeIcons.cloudRain,
    'txt': 'Chovendo',
    'cor': Colors.blueGrey,
    'cor_icone': Colors.black12,
    'cor_texto': Colors.black
  },
  'fog': {
    'icone': FontAwesomeIcons.smog,
    'txt': 'Névoa',
    'cor': Colors.black12,
    'cor_icone': Colors.white,
    'cor_texto': Colors.black
  },
  'clear_day': {
    'icone': FontAwesomeIcons.sun,
    'txt': 'Ensolarado',
    'cor': Colors.blue,
    'cor_icone': Colors.yellow,
    'cor_texto': Colors.white
  },
  'clear_night': {
    'icone':  FontAwesomeIcons.moon,
    'txt': 'Céu aberto',
    'cor': Colors.indigo,
    'cor_icone': Colors.grey,
    'cor_texto': Colors.black
  },
  'cloud': {
    'icone':   FontAwesomeIcons.cloud,
    'txt': 'Nublado',
    'cor': Colors.black12,
    'cor_icone': Colors.white,
    'cor_texto': Colors.black
  },
  'cloudly_day':  {
    'icone': FontAwesomeIcons.cloudSun,
    'txt': 'Dia nublado',
    'cor': Colors.black12,
    'cor_icone': Colors.white,
    'cor_texto': Colors.black
  },
  'cloudly_night':   {
    'icone': FontAwesomeIcons.cloudMoon,
    'txt': 'Noite nublada',
    'cor': Colors.black26,
    'cor_icone': Colors.grey,
    'cor_texto': Colors.white
  },
  'none_day': {
    'icone':  FontAwesomeIcons.sun,
    'txt': 'Dia',
    'cor': Colors.blue,
    'cor_icone': Colors.yellow,
    'cor_texto': Colors.white
  },
  'none_night': {
    'icone':   FontAwesomeIcons.moon,
    'txt': 'Noite',
    'cor': Colors.blueGrey,
    'cor_icone': Colors.grey,
    'cor_texto': Colors.white
  },
  };

  Function validaWOEID = ((value){
    if (value == '')
      return 'Digíte um WOEID válido';
    return null;
  });

  clicouBotao () async{
    if(!cForm.currentState.validate())
      return;
    String url = 'https://api.hgbrasil.com/weather?key=eb0ae66f&city_name=${controllerWOEID.text}';
    Response resposta = await get(url);
    Map tempo = json.decode(resposta.body);
    setState(() {
      temp      = tempo['results']['temp'];
      vento     = tempo['results']['wind_speedy'];
      condicao  = tempo['results']['condition_slug'];
      max       = tempo['results']['forecast'][0]['max'];
      min       = tempo['results']['forecast'][0]['min'];
      cidade    = tempo['results']['city'];
      previsao['dia 1']['max'] = tempo['results']['forecast'][1]['max'];
      previsao['dia 1']['min'] = tempo['results']['forecast'][1]['min'];
      previsao['dia 2']['max'] = tempo['results']['forecast'][2]['max'];
      previsao['dia 2']['min'] = tempo['results']['forecast'][2]['min'];
      previsao['dia 3']['max'] = tempo['results']['forecast'][3]['max'];
      previsao['dia 3']['min'] = tempo['results']['forecast'][3]['min'];
      previsao['dia 3']['date'] = tempo['results']['forecast'][3]['date'];
      previsao['dia 2']['date'] = tempo['results']['forecast'][2]['date'];
      previsao['dia 1']['date'] = tempo['results']['forecast'][1]['date'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: cForm,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 22),
                child: Image.asset(
                    'assets/imgs/logo.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: size.width*0.85,
                    height: 70,
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
                    child: Componentes.caixaDeTexto('Cidade', 'Ex: São Paulo,SP',
                                                    controllerWOEID, validaWOEID),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 10),
                    icon: FaIcon(
                      FontAwesomeIcons.search,
                      color: Colors.blue,
                    ),
                    onPressed: clicouBotao,
                  ),
                ],
              ),
              Container(
                height: size.height*0.7,
                width: size.width,
                color: icones[condicao]['cor'],
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 15, top: 10, left: 10,),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        cidade,
                        style: Componentes.estiloTexto(20, true, icones[condicao]['cor_texto']),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15, top: 0,),
                      child: Text(
                        'Tempo atual',
                        style: Componentes.estiloTexto(25, false, icones[condicao]['cor_texto']),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      width: size.width*0.95,
                      height: size.height*0.27,
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Text('$temp°C', style: Componentes.estiloTexto(52, false, Colors.black),),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Componentes.icone(FontAwesomeIcons.chevronUp, 22, Colors.red),
                                            Text('$max°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Componentes.icone(FontAwesomeIcons.chevronDown, 22, Colors.indigoAccent),
                                            Text('$min°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Componentes.icone(FontAwesomeIcons.wind, 25, Colors.white),
                                  Text('$vento', style: Componentes.estiloTexto(25, false, Colors.black),),
                                ],
                              ),
                              Column(
                                children: [
                                  Componentes.icone(icones[condicao]['icone'], 25, icones[condicao]['cor_icone']),
                                  Text('${icones[condicao]['txt']}', style: Componentes.estiloTexto(25, false, Colors.black),),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                            'Previsão',
                          style: Componentes.estiloTexto(20, true, icones[condicao]['cor_texto']),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(previsao['dia 1']['date']),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronUp, 22, Colors.red),
                                      Text('${previsao['dia 1']['max']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronDown, 22, Colors.indigoAccent),
                                      Text('${previsao['dia 1']['min']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(previsao['dia 2']['date']),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronUp, 22, Colors.red),
                                      Text('${previsao['dia 2']['max']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronDown, 22, Colors.indigoAccent),
                                      Text('${previsao['dia 2']['min']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(previsao['dia 3']['date']),
                                  Row(
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronUp, 22, Colors.red),
                                      Text('${previsao['dia 3']['max']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Componentes.icone(FontAwesomeIcons.chevronDown, 22, Colors.indigoAccent),
                                      Text('${previsao['dia 3']['min']}°C', style: Componentes.estiloTexto(25, false, Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


