
//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://th.bing.com/th/id/OIP.haWiqIAqd5Bic7Y7FXFfbwHaD2?rs=1&pid=ImgDetMain',
            fit: BoxFit.cover,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Peliculas",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              _buildButton(context, "Añadir Pelicula", Colors.blue, (){

                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AnadirPelicula()));

              }),

              _buildButton(context, "Peliculas Vistas", Colors.blue, (){

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PeliculasVistas()));

              }),

              _buildButton(context, "Pendientes por ver", Colors.blue,(){

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PendientesVer()));

              }),
            ],

          ),
        ],
      ),
    );
  }


  Widget _buildButton(BuildContext context, String text, Color color,VoidCallback onPressed){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed:onPressed,
      child: Center(
        child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),


    ),
    );
  }
}



class AnadirPelicula extends  StatefulWidget {
  @override
  AnadirDescripcion createState() => AnadirDescripcion();
}

class AnadirDescripcion extends State<AnadirPelicula> {

  final GlobalKey<FormState> llave = GlobalKey<FormState>();

  final TextEditingController tituloKey = TextEditingController();
  final TextEditingController anioKey = TextEditingController();
  final TextEditingController descripcionKey = TextEditingController();
  final TextEditingController categoriaKey = TextEditingController();

  void guardar() {
    if (llave.currentState!.validate()) {
      String titulo = tituloKey.text;
      String anio = anioKey.text;
      String descripcion = descripcionKey.text;
      String categoria = categoriaKey.text;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pelicula guardada exitosamente')),
    );

    tituloKey.clear();
    anioKey.clear();
    descripcionKey.clear();
    categoriaKey.clear();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Añadir Pelicula")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: llave,
            child: Column(
            children: [
              textField(tituloKey, "Titulo de la pelicula", "Ingrese titulo"),
              textField(anioKey, "Año de la pelicula", "Ingrese titulo"),
              textField(descripcionKey, "Descripcion", "Ingrese titulo"),
              textField(categoriaKey, "Categoria", "Ingrese titulo"),
              ElevatedButton(
                onPressed: guardar,
                child: Text("Guardar Pelicula")
    ),
    ],
    ),
    ),
    ),
    );
  }

  Widget textField(TextEditingController controller, String label, String errorMessage, {bool isNumeric=false}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value){
          if(value==null || value.isEmpty){
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}

class PeliculasVistas extends  StatelessWidget{
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("Peliculas Vistas")),
    body: Center(
        child: Text("Aqui se añaden peliculas")
    ),
  );
}
}

class PendientesVer extends  StatelessWidget{
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("PendientesVer")),
    body: Center(
        child: Text("Aqui se añaden peliculas")
    ),
  );
}
}
