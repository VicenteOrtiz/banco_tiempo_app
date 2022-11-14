class Badge {
  Badge({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
  });

  String id;
  String nombre;
  String imagenUrl;

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
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
