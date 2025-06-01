import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(article.title ?? localizations.noTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? localizations.noTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              article.description ?? localizations.noDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              article.publishedAt ?? localizations.noDate,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final url = article.url;
                if (url != null && await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.errorOpeningLink)),
                  );
                }
              },
              child: Text(localizations.readMore),
            ),
          ],
        ),
      ),
    );
  }
}
