import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokeflutter2/models/pokemon.dart';

class DetailsScreen extends StatefulWidget {
  final String pokemonUrl;

  const DetailsScreen({super.key, required this.pokemonUrl});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<PokemonDetails> _detailsFuture;

  @override
  void initState() {
    super.initState();
    _detailsFuture = _fetchPokemonDetails();
  }

  Future<PokemonDetails> _fetchPokemonDetails() async {
    final response = await http.get(Uri.parse(widget.pokemonUrl));
    if (response.statusCode == 200) {
      return PokemonDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar detalhes do Pokémon');
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<PokemonDetails>(
        future: _detailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final details = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      details.imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      capitalize(details.name),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text('Altura: ${details.height / 10} m', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('Peso: ${details.weight / 10} kg', style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Nenhum detalhe encontrado.'));
        },
      ),
    );
  }
}