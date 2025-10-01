class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}

class LocationRef {
  final String name;
  final String url;

  LocationRef({required this.name, required this.url});

  factory LocationRef.fromJson(Map<String, dynamic> json) {
    return LocationRef(name: json['name'], url: json['url']);
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String created;
  final String gender;
  final String image;
  final String url;
  final LocationRef origin;
  final LocationRef location;
  final List<String> episode;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.created,
    required this.gender,
    required this.image,
    required this.url,
    required this.origin,
    required this.location,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      created: json['created'],
      gender: json['gender'],
      image: json['image'],
      url: json['url'],
      origin: LocationRef.fromJson(json['origin']),
      location: LocationRef.fromJson(json['location']),
      episode: List<String>.from(json['episode']),
    );
  }
}

class CharacterResponse {
  Info info;
  List<Character> results;
  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: Info.fromJson(json['info']),
      results: List<Character>.from(
        json['results'].map((x) => Character.fromJson(x)),
      ),
    );
  }
}
