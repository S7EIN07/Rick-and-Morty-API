import 'package:flutter/material.dart';
import 'package:rickandmortyapi/character/characterslist.dart';
import 'package:rickandmortyapi/location/locationlist.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/img/logo.png", height: 50),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Column(
                children: [
                  Image.asset("assets/img/characters.png", width: 150),
                  Image.asset("assets/img/CharactersText.png", width: 120),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CharactersPage()),
                );
              },
            ),
            GestureDetector(
              child: Column(
                children: [
                  Image.asset("assets/img/episodes.png", width: 150),
                  Image.asset("assets/img/EpisodesText.png", width: 120),
                ],
              ),
              onTap: () {
                debugPrint("episodes");
              },
            ),
            GestureDetector(
              child: Column(
                children: [
                  Image.asset("assets/img/locations.png", width: 150),
                  Image.asset("assets/img/LocationsText.png", width: 120),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
