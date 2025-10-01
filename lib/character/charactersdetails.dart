import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/model/Character.dart';

class CharactersDetailsPage extends StatelessWidget {
  final int id;

  const CharactersDetailsPage({Key? key, required this.id}) : super(key: key);

  Future<Character> getCharacterDetails() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$id'),
    );

    if (response.statusCode == 200) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load character details');
    }
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
        title: Image.asset("assets/img/DetailsCharactersText.png", height: 50),
        centerTitle: true,
      ),
      body: FutureBuilder<Character>(
        future: getCharacterDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final character = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(character.image, height: 200),
                    const SizedBox(height: 16),
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Status: ${character.status}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Species: ${character.species}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Gender: ${character.gender}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Origin: ${character.origin.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Location: ${character.location.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("No data"));
        },
      ),
    );
  }
}
