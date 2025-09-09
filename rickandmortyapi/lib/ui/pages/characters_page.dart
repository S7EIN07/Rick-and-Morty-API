import 'package:flutter/material.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Characters")),
      body: Center(child: Text("CHARACTERS")),
    );
  }
}
