import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CharactersPage extends StatefulWidget {
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}


class _CharactersPageState extends State<CharactersPage> {
  Future<http.Response> getCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      // criar objeto
      return response;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Characters")),
      body: FutureBuilder<http.Response>(
        future: getCharacters(),
        builder: (context, snapshot) {
          return Center(child: Text("CHARACTERS"));
        },
      ),
    );
  }
}
