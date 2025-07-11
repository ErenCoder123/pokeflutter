import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=151';

  Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((e) => Pokemon.fromJson(e)).toList();
      } else {
        throw Exception('Falha ao carregar a lista de Pokémon');
      }
    } catch (e) {
      throw Exception('Erro de conexão: ${e.toString()}');
    }
  }
}