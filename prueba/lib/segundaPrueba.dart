
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main(){
  runApp(Test());
}

class Test extends StatelessWidget{
  const Test({super.key});

  @override
  Widget build(BuildContext context){
    //return MaterialApp(
      //home: Scaffold(
        //appBar: AppBar(
          //title: Text('Prueba'),
        //),
        //body: Center(
          //child: Text('Hello world'),
        //),
      //),
    //);

    return MaterialApp(
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplo de footer'),
      ),
      body: Column(
        children: [
          // Contenido principal
          Expanded(
            child: Center(
              child: Text(
                'Contenido principal',
                style: TextStyle(fontSize: 34),
              ),
            ),
          ),
          // Footer
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blueAccent,
            width: double.infinity,
            child: Text(
              'Este es un Footer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

  }

}