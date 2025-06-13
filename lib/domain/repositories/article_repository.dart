import 'package:news_app/data/models/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> fetchArticles(String apiKey);
}