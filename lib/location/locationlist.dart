import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/location/locationdetails.dart';
import 'package:rickandmortyapi/model/Location.dart';

class LocationsPage extends StatefulWidget {
  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final List<Location> locations = [];
  final ScrollController _scrollController = ScrollController();

  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchCharacters();
      }
    });
  }

  Future<void> fetchCharacters() async {
    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/location/?page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newLocations = LocationResponse.fromJson(data).results;

      setState(() {
        locations.addAll(newLocations);
        page++;
        hasMore = data["info"]["next"] != null;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load characters');
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
        title: Image.asset("assets/img/CharactersText.png", height: 50),
        centerTitle: true,
      ),
      body: locations.isEmpty && isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 144, 255, 16),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: locations.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == locations.length) {
                  // Loader no fim da lista
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 144, 255, 16),
                      ),
                    ),
                  );
                }

                final location = locations[index];
                return ListTile(
                  title: Text(
                    location.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    location.type,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: GestureDetector(
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
                        "Detalhes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LocationDetailsPage(id: location.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
