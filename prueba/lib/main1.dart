// main1.dart
import 'package:flutter/material.dart';
import 'main2.dart';  // Asegúrate de importar main2.dart aquí

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main1Page(),  // Página principal es Main1Page
    );
  }
}

class Main1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main 1 - Página Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Al presionar el botón, navega a Main2Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Main2Page()),
                );
              },
              child: Text('Ir a Main 2'),
            ),
          ],
        ),
      ),
    );
  }
}
