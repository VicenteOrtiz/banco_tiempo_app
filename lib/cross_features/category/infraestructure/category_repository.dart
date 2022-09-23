import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/cross_features/category/infraestructure/datasource/category_datasource.dart';

import 'models/category_dto.dart';

class CategoryRepository {
  final _dataSource = CategoryDatasource();

  Future<List<Categoria>?> getCategories() async {
    return await _dataSource.getCategories().then((value) {
      if (value == null) {
        print("ENTRA AL NULL");
        return null;
      } else {
        List<Categoria> categorias = value.map((e) => e.toDomain()).toList();
        print(categorias);
        return categorias;
      }
    });
  }
}
