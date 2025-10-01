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

class LocationResponse {
  Info info;
  List<Location> results;

  LocationResponse({required this.info, required this.results});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      info: Info.fromJson(json['info']),
      results: List<Location>.from(
        json['results'].map((x) => Location.fromJson(x)),
      ),
    );
  }
}

class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residents: List<String>.from(json['residents']),
      url: json['url'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
      'residents': residents,
      'url': url,
      'created': created,
    };
  }
}
