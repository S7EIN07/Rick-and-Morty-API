import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/model/Location.dart';

class LocationDetailsPage extends StatelessWidget {
  final int id;

  const LocationDetailsPage({Key? key, required this.id}) : super(key: key);

  Future<Location> getLocationDetails() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/location/$id'),
    );

    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load location details');
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
        title: Image.asset("assets/img/DetailsCharactersText.png", height: 50),
        centerTitle: true,
      ),
      body: FutureBuilder<Location>(
        future: getLocationDetails(),
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
            final location = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Type: ${location.type}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "Dimension: ${location.dimension}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Residents:",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: location.residents.length,
                      itemBuilder: (context, index) {
                        return Text(
                          location.residents[index],
                          style: const TextStyle(color: Colors.white70),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "URL: ${location.url}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Created: ${location.created}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
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
