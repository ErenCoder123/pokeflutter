import 'dart:convert';

class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }

  String get id {
    final parts = url.split('/');
    return parts.length > 2 ? parts[parts.length - 2] : '1';
  }

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}


class PokemonDetails {
  final String name;
  final int height;
  final int weight;
  final String imageUrl;

  PokemonDetails({
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}