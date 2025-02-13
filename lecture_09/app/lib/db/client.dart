import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app/db/model.dart';

class RestClient {
  final String baseUrl = "http://10.0.2.2:3000";

  Future<List<Emp>> get(int? id) async {
    if (id == null) {
      // Get all employees
      http.Response response = await http.get(Uri.parse('$baseUrl/emp'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Emp> employees =
            body.map((dynamic item) => Emp.fromJson(item)).toList();
        return employees;
      } else {
        return [];
      }
    } else {
      // Get employee by id
      http.Response response = await http.get(
        Uri.parse('$baseUrl/emp/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return [Emp.fromJson(jsonDecode(response.body))];
      } else {
        return [];
      }
    }
  }

  Future<Emp?> post(Emp body) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/emp'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );

    if (response.statusCode == 201) {
      return Emp.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Emp?> put(int id, Emp body) async {
    http.Response response = await http.put(
      Uri.parse('$baseUrl/emp/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );

    if (response.statusCode == 200) {
      return Emp.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Emp?> delete(int id) async {
    http.Response response = await http.delete(
      Uri.parse('$baseUrl/emp/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      return Emp.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
