import 'package:banco_tiempo_app/secrets.dart';

import '../models/category_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CategoryDatasource {
  Future<List<CategoryDto>?> getCategories() async {
    var url = Uri.https(baseUrl, "/api/categorias");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        /*  var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>; */
        List<CategoryDto> categoryList = categoryDtoFromJson(response.body);
        return categoryList;
      } else {
        return null;
      }
    } catch (e, s) {
      return null;
    }
  }
}
