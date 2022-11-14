import 'package:banco_tiempo_app/cross_features/badges/infraestructure/datasource/badge_datasource.dart';

import '../domain/badges_entity.dart';

class BadgeRepository {
  final _dataSource = BadgeDatasource();

  Future<List<Badge>?> getCategories() async {
    return await _dataSource.getBadges().then((value) {
      if (value == null) {
        print("ENTRA AL NULL");
        return null;
      } else {
        List<Badge> badges = value.map((e) => e.toDomain()).toList();
        // Se agrega un elemento inicial para que haya un "no seleccionado"
        badges.insert(
            0, Badge(id: '0', imagenUrl: '', nombre: 'Seleccionar Categoría'));
        print(badges);
        return badges;
      }
    });
  }
}
