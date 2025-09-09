import 'package:flutter/material.dart';
import 'package:rickandmortyapi/ui/pages/characters_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Rick and Morty API"))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Image.asset("assets/img/characters.png", width: 150),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CharactersPage()),
                );
              },
            ),
            GestureDetector(
              child: Image.asset("assets/img/episodes.png", width: 150),
              onTap: () {
                debugPrint("episodes");
              },
            ),
            GestureDetector(
              child: Image.asset("assets/img/locations.png", width: 150),
              onTap: () {
                debugPrint("locations");
              },
            ),
          ],
        ),
      ),
    );
  }
}
