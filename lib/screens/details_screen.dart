import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    String pokemonName = pokemon.name[0].toUpperCase() + pokemon.name.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: pokemon.id,
              child: Image.network(
                pokemon.imageUrl,
                height: 250,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 100);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              pokemonName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nº ${pokemon.id}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}