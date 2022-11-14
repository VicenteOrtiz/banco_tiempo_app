import '../../../../secrets.dart';

import '../models/badges_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BadgeDatasource {
  Future<List<BadgeDto>?> getBadges() async {
    var url = Uri.https(baseUrl, "/api/obtenerCualidades");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        /*  var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>; */
        List<BadgeDto> categoryList = badgesDtoFromJson(response.body);
        //print(categoryList);
        return categoryList;
      } else {
        return null;
      }
    } catch (e, s) {
      return null;
    }
  }
}
