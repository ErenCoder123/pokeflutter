import 'package:flutter/material.dart';
import 'package:pokeflutter2/models/pokemon.dart';
import 'package:pokeflutter2/screens/details_screen.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        pokemon.imageUrl,
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
      title: Text(capitalize(pokemon.name)),
      subtitle: Text('ID: ${pokemon.id}'),
      onTap: () {
        // Navegação para a tela de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(pokemonUrl: pokemon.url),
          ),
        );
      },
    );
  }
}