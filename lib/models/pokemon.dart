class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  String get id {
    final parts = url.split('/');
    return parts[parts.length - 2];
  }

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}