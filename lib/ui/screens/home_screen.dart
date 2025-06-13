import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/article.dart';
import '../../data/services/api_service.dart';
import 'article_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? apiKey;
  const HomeScreen({super.key, this.apiKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> _articles;
  List<Article> _favoriteArticles = [];

  @override
  void initState() {
    super.initState();
    _articles = widget.apiKey == null
        ? Future.error('API key is missing')
        : ApiService().fetchArticles(widget.apiKey!);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favoriteArticles = favoritesJson
          .map((json) {
            try {
              return Article.fromJson(jsonDecode(json));
            } catch (e) {
              print('Ошибка десериализации: $e');
              return null;
            }
          })
          .where((article) => article != null)
          .cast<Article>()
          .toList();
    });
  }

  Future<void> _toggleFavorite(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoriteArticles.any((fav) => fav.title == article.title)) {
        _favoriteArticles.removeWhere((fav) => fav.title == article.title);
      } else {
        _favoriteArticles.add(article);
      }
      final favoritesJson =
          _favoriteArticles.map((article) => jsonEncode(article.toJson())).toList();
      prefs.setStringList('favorites', favoritesJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${localizations.errorLoading}: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(localizations.noArticles));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              final isFavorite = _favoriteArticles.any((fav) => fav.title == article.title);

              return Card(
                child: ListTile(
                  leading: article.urlToImage != null
                      ? Image.network(article.urlToImage!, width: 100, fit: BoxFit.cover)
                      : const Icon(Icons.image, size: 100),
                  title: Text(article.title ?? localizations.noTitle),
                  subtitle: Text(
                    article.description ?? localizations.noDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(article),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleScreen(article: article),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}