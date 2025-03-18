class Pelicula {
  int?  id;
  String titulo;
  String anio;
  String descripcion;
  String categoria;
  String clasi;
  int puntuacion;


  Pelicula({
    this.id,
    required this.titulo,
    required this.anio,
    required this.descripcion,
    required this.categoria,
    required this.clasi,
    required this.puntuacion,
  });

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'titulo' : titulo,
      'anio': anio,
      'descripcion': descripcion,
      'categoria': categoria,
      'clasi': clasi,
      'puntuacion': puntuacion,
    };
  }

  static Pelicula fromMap(Map<String, dynamic> map){
        return Pelicula(
          id: map['id'],
          titulo: map['titulo'],
          anio: map['anio'],
          descripcion: map['descripcion'],
          categoria: map['categoria'],
          clasi: map['clasi'],
          puntuacion: map['puntuacion'],
        );
  }


  }


