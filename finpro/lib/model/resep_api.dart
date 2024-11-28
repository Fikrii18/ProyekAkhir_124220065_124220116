import 'dart:convert';
import 'package:finpro/model/resep.dart';
import 'package:http/http.dart' as http;

class ResepApi {
  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {'from': '0', 'size': '20', 'tags': 'under_30_minutes'});
    final Response = await http.get(uri, headers: {
      'x-rapidapi-key': '111534c6dfmsh36be6901e8bbb25p1197c3jsndc0644be29ae',
      'x-rapidapi-host': 'tasty.p.rapidapi.com',
      'useQueryString': 'true'
    });

    Map data = jsonDecode(Response.body);
    List _temp = [];
    for (var i in data['results']) {
      _temp.add(i);
    }
    return Resep.resepFromSnapshot(_temp);
  }
}
