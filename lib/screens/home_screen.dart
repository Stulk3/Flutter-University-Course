import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import 'article_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? apiKey;
  const HomeScreen({super.key, this.apiKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> _articles;

  @override
  void initState() {
    super.initState();
    _articles = widget.apiKey == null
        ? Future.error('API key is missing')
        : ApiService().fetchArticles(apiKey: widget.apiKey!);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.pushNamed(context, '/about'),
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