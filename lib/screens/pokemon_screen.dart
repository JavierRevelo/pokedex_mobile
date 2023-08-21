import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class PokemonScreenWidget extends StatefulWidget {
  const PokemonScreenWidget({super.key});

  @override
  State<PokemonScreenWidget> createState() => _PokemonScreenWidgetState();
}

class _PokemonScreenWidgetState extends State<PokemonScreenWidget> {
  bool isSerach= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          setState(() {
            isSerach=!isSerach;
          });
        }, 
        icon: const Icon(Icons.search))
        ],
        title:isSerach? const Text('Pokemons'): const Text('Search'),
      ),
      body: FutureBuilder(future: Provider.of<PokemonProvider>(context,listen: false).checkPokemons(),
      builder: (context, snapshot){
        if (snapshot.hasData) {// cuando la llamada al metodo asiuncronico se ejecuta
          return const PokemonList();
        }else{ // cuando la llamada al metodo async esta en proceso
          return const Center(child: CircularProgressIndicator());
        }
      },
      ),
    );// permite hacer llaamdas a un metodo de tipo asyncronico
  }
}