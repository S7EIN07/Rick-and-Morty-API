import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/character/charactersdetails.dart';
import 'package:rickandmortyapi/model/Character.dart';

class CharactersPage extends StatefulWidget {
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  Future<List<Character>> getCharacters() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );
    if (response.statusCode == 200) {
      return CharacterResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Characters")),
      body: FutureBuilder(
        future: getCharacters(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            // mostrar na tela
            var characters = snapshot.data as List<Character>;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(characters[index].image),
                  title: Text(characters[index].name),
                  subtitle: Text(characters[index].species),
                  trailing: MouseRegion(
                    cursor: SystemMouseCursors.click, // Adicione esta linha
                    child: GestureDetector(
                      child: Container(
                        child: Text("Detalhes", style: TextStyle(fontSize: 16)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharactersDetailsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
