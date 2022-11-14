class Categoria {
  Categoria({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
  });

  String id;
  String nombre;
  String imagenUrl;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
        imagenUrl: json["imagenUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "imagenUrl": imagenUrl,
      };
}
