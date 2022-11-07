import '../../../cross_features/category/domain/category_entity.dart';

class Publication {
  Publication({
    required this.id,
    required this.publicado,
    required this.descripcion,
    required this.titulo,
    required this.creador,
    required this.v,
    required this.inscritos,
    required this.comentarios,
    required this.imagenes,
    required this.horas,
    required this.oculta,
    required this.categorias,
  });

  String id;
  DateTime publicado;
  String descripcion;
  String titulo;
  String creador;
  int v;
  List<dynamic> inscritos;
  List<String> comentarios;
  List<String> imagenes;
  int horas;
  bool oculta;
  List<Categoria> categorias;
}
