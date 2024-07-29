import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/model/model.dart';

const String url = 'https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo';

class ApiService {
  Future<List<Model>> fetchProductData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Model.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
