
//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Pelicula.dart';
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
  static List<Pelicula> peliculasVistas=[];
  static List<Pelicula> pendientesVer=[];


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
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              _buildButton(context, "Añadir Pelicula", Colors.white, (){

                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AnadirPelicula()));

              }),

              _buildButton(context, "Peliculas Vistas", Colors.white, (){

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PeliculasVistas()));

              }),

              _buildButton(context, "Pendientes por ver", Colors.white,(){

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
            style: TextStyle(fontSize: 18, color: Colors.black),
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

  String clasiSele ="";
  int puntuacion=0;

  void guardar() async {
    if (llave.currentState!.validate()) {
      String titulo = tituloKey.text;
      String anio = anioKey.text;
      String descripcion = descripcionKey.text;
      String categoria = categoriaKey.text;


      Pelicula peli = Pelicula(
          titulo: titulo,
          anio: anio,
          descripcion: descripcion,
          categoria: categoria,
          clasi: clasiSele,
          puntuacion: puntuacion,
      );



      if(clasiSele == "vista") {
        HomeScreen.peliculasVistas.add(peli);
      } else if (clasiSele == "no vista") {
        HomeScreen.pendientesVer.add(peli);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pelicula guardada exitosamente')),
      );

      tituloKey.clear();
      anioKey.clear();
      descripcionKey.clear();
      categoriaKey.clear();
    }
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
              textField(anioKey, "Año de la pelicula", "Año de estreno "),
              textField(descripcionKey, "Descripcion", "Ingrese titulo"),
              textField(categoriaKey, "Categoria", "Ingrese titulo"),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        setState((){
                          clasiSele="vista";
                        });
                        guardar();
                      },
                      child: Text("Vistas"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        setState((){
                          clasiSele="no vista";
                        });
                        guardar();
                      },
                      child: Text("Pendiente Ver"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                ],
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

class PeliculasVistas extends StatefulWidget {
  @override
  vistasState createState() => vistasState();
}

class vistasState extends State<PeliculasVistas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Peliculas Vistas")),
      body: ListView.builder(
        itemCount: HomeScreen.peliculasVistas.length,
        itemBuilder: (context, index) {
          Pelicula pelicula = HomeScreen.peliculasVistas[index];

          double puntuacion = pelicula.puntuacion.toDouble();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Card(
              elevation: 5, // Agrega sombra para hacer que se vea más prominente
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Añadir padding interno
                title: Text(
                  pelicula.titulo,
                  style: TextStyle(
                    fontSize: 22, // Aumentar el tamaño del título
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      pelicula.descripcion,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Año: ${pelicula.anio}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Puntuación: ${puntuacion.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Expanded(
                          child: Slider(
                            value: puntuacion,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            label: puntuacion.toStringAsFixed(1),
                            onChanged: (newRating) {
                              setState(() {
                                pelicula.puntuacion = newRating.toInt();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      HomeScreen.peliculasVistas.removeAt(index);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class PendientesVer extends StatefulWidget {
  @override
  pendientesState createState() => pendientesState();
}

class pendientesState extends State<PendientesVer> {
  // Función para mover la película a la lista de vistas
  void moverAPeliculasVistas(int index) {
    // Obtener la película que vamos a mover
    Pelicula pelicula = HomeScreen.pendientesVer[index];

    // Añadirla a la lista de películas vistas
    HomeScreen.peliculasVistas.add(pelicula);

    // Eliminarla de la lista de pendientes
    HomeScreen.pendientesVer.removeAt(index);

    // Actualizar la UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pendientes de ver")),
      body: ListView.builder(
        itemCount: HomeScreen.pendientesVer.length,
        itemBuilder: (context, index) {
          Pelicula pelicula = HomeScreen.pendientesVer[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Card(
              elevation: 5, // Agrega sombra para hacer que se vea más prominente
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Añadir padding interno
                title: Text(
                  pelicula.titulo,
                  style: TextStyle(
                    fontSize: 22, // Aumentar el tamaño del título
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      pelicula.descripcion,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Año: ${pelicula.anio}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pelicula.anio,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        moverAPeliculasVistas(index); // Llamar a la función para mover la película
                      },
                      child: Text("Marcar como vista"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

