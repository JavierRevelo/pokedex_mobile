import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_mobile/dtos/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  final List<Pokemon> _originalPokemons = [];
  List<Pokemon> _pokemon = [];

  int get totalPokemons => _pokemon.length;

  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemon);
  Pokemon getPokemon(int id) {
    return _pokemon.firstWhere((pokemon) => pokemon.id == id);
  }

  Future<void> updatePokemonFavoriteStatus(int id, bool value) async {
    var db = FirebaseFirestore.instance;
    await db.collection('pokemons').doc(id.toString()).update(
      {'isFavorite': value},
    );
  }

  void searchPokemonsByName(String name) {
    _pokemon = _originalPokemons
        .where((element) => element.name.contains(name))
        .toList();
    notifyListeners();
  }

  void clearSearch(){
    _pokemon=[..._originalPokemons];
    notifyListeners();
  }

  Future<bool> checkPokemons() async {
    if (_pokemon.isEmpty) {
      await initPokemonList();
      return true;
    }else{
      clearSearch();
    }
    return false;
  }

  Future<void> initPokemonList() async {
    var client = http.Client();
    var response = await client.get(Uri.http('pokeapi.co', '/api/v2/pokemon'));
    print(
        'statusPokemon: ${response.statusCode}'); //codigo de retorno http 20x-OK 40x-Error Cliente 50x-Error servidor
    // print('pokemon List: ${response.body}');
    //DART - JSON Map<String, Object> => List
    var decodeResponse = jsonDecode(response.body);
    var results = decodeResponse['results'] as List;
    for (var ri in results) {
      //Map<String, Object>
      var url = ri['url'] as String;
      await addPokemonList(url);
    }
    notifyListeners();
  }

  void addCommentToPokemonDoc(int id, String com) {
    var db = FirebaseFirestore.instance;
    final commentObj = <String, dynamic>{'comment': com};
    var setOptions = SetOptions(merge: true);
    db.collection('pokemons').doc(id.toString()).set(commentObj, setOptions);
  }

  Future<void> addPokemonList(String url) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    var pokemonData = jsonDecode(response.body);
    _pokemon.add(Pokemon.fromJson(pokemonData));
    _originalPokemons.add(Pokemon.fromJson(pokemonData));

    //Mapa con la definicion del documento
    final pokemonDocument = <String, dynamic>{
      //'id': pokemonData['id'],
      'name': pokemonData['name'],
      'id': pokemonData['id'],
      'imageUrl': pokemonData['sprites']['front_default']
    };

    //Instancia de firestore
    var db = FirebaseFirestore.instance;
    /*
    Future:
      await future();
      future().then(
        (value) => {}
      )
    */

    //Agregar documentos en la base con ids autogenerados
    // db.collection("pokemons").add(pokemonDocument).then((value)=> print('success'));
    var setOptions = SetOptions(merge: true);

    db
        .collection("pokemons")
        .doc(pokemonData['id'].toString())
        .set(pokemonDocument, setOptions)
        .then((value) => print('success'));
  }
}
