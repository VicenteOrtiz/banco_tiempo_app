class CreatePublicationFormEntity {
  CreatePublicationFormEntity({
    required this.title,
    required this.description,
    required this.categories,
    required this.hours,
    required this.images,
  });

  String title;
  String description;
  List<String> categories;
  String hours;
  List<String> images;

  factory CreatePublicationFormEntity.initial() => CreatePublicationFormEntity(
        title: "",
        description: "",
        categories: [],
        hours: "",
        images: [],
      );

  factory CreatePublicationFormEntity.fromJson(Map<String, dynamic> json) =>
      CreatePublicationFormEntity(
        categories: List<String>.from(json["categorias"].map((x) => x)),
        description: json["descripcion"],
        hours: json["horas"],
        images: List<String>.from(json["imagenes"].map((x) => x)),
        title: json["titulo"],
      );

  Map<String, dynamic> toJson() => {
        "categorias": List<String>.from(categories.map((x) => x)),
        "descripcion": description,
        "horas": hours,
        "imagenes": List<String>.from(images.map((x) => x)),
        "titulo": title,
      };
}
