import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/episodes/episodesdetails.dart';
import 'package:rickandmortyapi/model/Episodes.dart';

class EpisodesList extends StatefulWidget {
  const EpisodesList({super.key});

  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  final List<Episode> episodes = [];
  final ScrollController _scrollController = ScrollController();

  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchEpisodes();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchEpisodes();
      }
    });
  }

  Future<void> fetchEpisodes() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/episode/?page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newEpisodes = EpisodeResponse.fromJson(data).results;

      setState(() {
        episodes.addAll(newEpisodes);
        page++;
        hasMore = data["info"]["next"] != null;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      // Aqui você pode adicionar um tratamento de erro mais robusto, como mostrar um Snackbar.
      // ignore: avoid_print
      print('Failed to load episodes: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/img/return.png"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Image.asset("assets/img/EpisodesText.png", height: 50),
        centerTitle: true,
      ),
      body: episodes.isEmpty && isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 144, 255, 16),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: episodes.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == episodes.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 144, 255, 16),
                      ),
                    ),
                  );
                }

                final episode = episodes[index];
                return ListTile(
                  title: Text(
                    episode.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Air Date: ${episode.airDate}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EpisodeDetailsPage(id: episode.id),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 144, 255, 16),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
