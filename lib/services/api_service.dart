import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchArticles({required String apiKey}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> articlesJson = json['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}