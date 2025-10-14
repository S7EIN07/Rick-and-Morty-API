import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/model/Episodes.dart';

class EpisodeDetailsPage extends StatelessWidget {
  final int id;

  const EpisodeDetailsPage({Key? key, required this.id}) : super(key: key);

  Future<Episode> getEpisodeDetails() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/episode/$id'),
    );

    if (response.statusCode == 200) {
      return Episode.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load episode details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/img/return.png"),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
        title: Image.asset("assets/img/DetailsEpisodesText.png", height: 50),
        centerTitle: true,
      ),
      body: FutureBuilder<Episode>(
        future: getEpisodeDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 144, 255, 16),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            final episode = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Episode: ${episode.episode}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Air Date: ${episode.airDate}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Characters:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...episode.characters
                        .map(
                          (characterUrl) => Text(
                            characterUrl,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 16),
                    Text(
                      "URL: ${episode.url}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Created: ${episode.created}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text("No data", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}
