import 'package:flutter/material.dart';
import 'package:pokedex_mobile/dtos/pokemon_model.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class PokemonScreenWidget extends StatefulWidget {
  const PokemonScreenWidget({super.key});

  @override
  State<PokemonScreenWidget> createState() => _PokemonScreenWidgetState();
}

class _PokemonScreenWidgetState extends State<PokemonScreenWidget> {
  var textSearchCobntroller = TextEditingController();
  bool isSerach = true;
  @override
  void initState(){
    textSearchCobntroller.addListener(_searchPokemons);
    super.initState();
  }

  _searchPokemons(){
    if (textSearchCobntroller.text.isNotEmpty) {
      Provider.of<PokemonProvider>(context,listen: false).searchPokemonsByName(textSearchCobntroller.text);
      
    }
  }

  _clearSearch(){
    Provider.of<PokemonProvider>(context,listen: false).clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSerach = !isSerach;
                  _clearSearch();
                });
              },
              icon: const Icon(Icons.search))
        ],
        title: isSerach ? const Text('Pokemons') :TextField(
          controller:textSearchCobntroller,
          decoration:  InputDecoration(
            hintText: 'Buscar',icon: const Icon(Icons.search),
            suffixIcon: IconButton(onPressed: () {
              textSearchCobntroller.text='';
              _clearSearch();
            }, icon: const Icon(Icons.cancel))
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<PokemonProvider>(context, listen: false)
            .checkPokemons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // cuando la llamada al metodo asiuncronico se ejecuta
            return const PokemonList();
          } else {
            // cuando la llamada al metodo async esta en proceso
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ); // permite hacer llaamdas a un metodo de tipo asyncronico
  }
}
