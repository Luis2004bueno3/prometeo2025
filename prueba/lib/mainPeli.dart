

import 'package:flutter/material.dart';
import 'pelicula.dart';


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Registro de peliculas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaPeliculas(),
    );
  }
}


class ListaPeliculas extends StatelessWidget{
  List<Pelicula> peliculas=[
    Pelicula(
      titulo: 'Venom: El Ultimo baile',
      anio: 2024,
      descripcion: 'Esquivan las amenazas de un lider vigilante',
      categoria: 'accion',
    ),
    Pelicula(
      titulo: 'Mi villano favorito 4',
      anio: 2024,
      descripcion: 'Llega un nuevo bebe a la familia gru',
      categoria: 'accion',
    ),
    Pelicula(
      titulo: 'Mi villano favorito 3',
      anio: 2017,
      descripcion: 'Gru pierde su trabajo y necesita ayuda',
      categoria: 'accion',
    ),
    Pelicula(
      titulo: 'Minions',
      anio: 2015,
      descripcion: 'Los secuaces de gru son los mejores',
      categoria: 'accion',
    ),
  ];

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de peliculas'),
      ),
      body: ListView.builder(
        itemCount: peliculas.length,
        itemBuilder: (context, index){
          final pelicula= peliculas[index];
          return ListTile(
            title: Text(pelicula.titulo),
            subtitle: Text('Año: ${pelicula.anio}'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesPelicula(pelicula: pelicula),
                ),
              );
            },
          );
        },
      ),
    );
  }

}

class DetallesPelicula extends StatelessWidget{
  Pelicula pelicula;

  DetallesPelicula({required this.pelicula});

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text(pelicula.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              pelicula.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Año: ${pelicula.anio}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(pelicula.descripcion),
          ],
        ),
      ),
    );
  }

}