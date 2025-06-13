import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/services/api_service.dart';
import '../../mocks/mock_api_service.dart';

void main() {
  group('ApiService', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    test('fetchArticles returns a list of articles', () async {
      when(mockApiService.fetchArticles('test_api_key')).thenAnswer(
        (_) async => [Article(title: 'Test Article', description: 'Test Description')],
      );

      final articles = await mockApiService.fetchArticles('test_api_key');
      expect(articles, isA<List<Article>>());
      expect(articles.first.title, 'Test Article');
    });

    test('fetchArticles throws an exception for invalid API key', () async {
      when(mockApiService.fetchArticles('invalid_api_key')).thenThrow(Exception('Invalid API key'));

      expect(
        () async => await mockApiService.fetchArticles('invalid_api_key'),
        throwsException,
      );
    });
  });
}