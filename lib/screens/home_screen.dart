import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/auth_service.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_list_item.dart'; // Importa o novo widget reutilizável

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokemonService _pokemonService = PokemonService();
  final AuthService _authService = AuthService();
  late Future<List<Pokemon>> _pokemonListFuture;

  @override
  void initState() {
    super.initState();
    _pokemonListFuture = _pokemonService.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex de ${user?.displayName ?? 'Treinador'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
            },
            tooltip: 'Sair',
          ),
        ],
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _pokemonListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar Pokémon: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum Pokémon encontrado.'));
          }

          final pokemonList = snapshot.data!;
          return ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return PokemonListItem(pokemon: pokemon);
            },
          );
        },
      ),
    );
  }
}