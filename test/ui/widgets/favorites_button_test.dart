import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    // Очищаем SharedPreferences перед каждым тестом
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  testWidgets('Favorites button toggles state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(apiKey: 'test_api_key'),
      ),
    );

    // Проверяем, что кнопка избранного отображается
    expect(find.byIcon(Icons.favorite_border), findsWidgets);

    // Нажимаем на кнопку избранного
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    // Проверяем, что состояние кнопки изменилось
    expect(find.byIcon(Icons.favorite), findsWidgets);
  });
}