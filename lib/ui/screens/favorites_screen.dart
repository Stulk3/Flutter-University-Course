import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/article.dart';
import 'article_screen.dart';
import '../../l10n/app_localizations.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Article> _favoriteArticles = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favoriteArticles = favoritesJson
          .map((json) => Article.fromJson(jsonDecode(json)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.favoritesScreenTitle)),
      body: _favoriteArticles.isEmpty
          ? Center(child: Text(localizations.noArticles))
          : ListView.builder(
              itemCount: _favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = _favoriteArticles[index];
                return ListTile(
                  title: Text(article.title ?? localizations.noTitle),
                  subtitle: Text(article.description ?? localizations.noDescription),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}