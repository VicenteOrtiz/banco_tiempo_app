import '../domain/category_entity.dart';
import 'datasource/category_datasource.dart';

class CategoryRepository {
  final _dataSource = CategoryDatasource();

  Future<List<Categoria>?> getCategories() async {
    return await _dataSource.getCategories().then((value) {
      if (value == null) {
        print("ENTRA AL NULL");
        return null;
      } else {
        List<Categoria> categorias = value.map((e) => e.toDomain()).toList();
        // Se agrega un elemento inicial para que haya un "no seleccionado"
        categorias.insert(0,
            Categoria(id: '0', imagenUrl: '', nombre: 'Seleccionar Categoría'));
        //print(categorias);
        return categorias;
      }
    });
  }
}
