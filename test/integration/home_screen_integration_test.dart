import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays articles fetched from API', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(apiKey: 'test_api_key'),
      ),
    );

    // Проверяем, что заголовок экрана отображается
    expect(find.text('News App'), findsOneWidget);

    // Мокируем данные
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);
  });
}