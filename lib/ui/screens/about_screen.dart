import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../../data/models/card_model.dart';
import '../../l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<List<CardModel>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = _loadCards();
  }

  Future<List<CardModel>> _loadCards() async {
    final String jsonString =
        await rootBundle.loadString('assets/cards.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => CardModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.aboutScreenTitle)),
      body: FutureBuilder<List<CardModel>>(
        future: _cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки данных'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных'));
          }

          final cards = snapshot.data!;
          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(card.photoUrl),
                            radius: 40,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            card.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            card.company,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Телефон: ${card.phone}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('Почта: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () async {
                                  final emailUri = Uri(
                                    scheme: 'mailto',
                                    path: card.email,
                                  );
                                  if (await canLaunchUrl(emailUri)) {
                                    await launchUrl(emailUri);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Не удалось открыть почту')),
                                    );
                                  }
                                },
                                child: Text(
                                  card.email,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('GitHub: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () async {
                                  final githubUri = Uri.parse(card.github);
                                  if (await canLaunchUrl(githubUri)) {
                                    await launchUrl(githubUri);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Не удалось открыть GitHub')),
                                    );
                                  }
                                },
                                child: Text(
                                  card.github,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}