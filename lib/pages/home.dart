import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/data/pokemon.dart';
import 'package:pokemon/main.dart';
import 'package:pokemon/pages/pokemon_detail.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var pokeApi = "https://pokeapi.co/api/v2/pokemon/";
  late List pokedex = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 85,
              left: 20,
              child: Text('Pokemons',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              )),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
            children: [
             Expanded(child:
             GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               childAspectRatio: 1.4,
             ),
               itemCount: pokedex.length,
               semanticChildCount: pokedex.length,
               cacheExtent: 1000,
               itemBuilder: (context, index){
                var types = pokedex[index]['types'];
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getColorForType(types),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Stack(
                        children: [
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Text(
                                pokedex[index]['name'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                              ),
                            ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: types.map<Widget>((type) {
                                return Text(
                                  type['type']['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white),
                                );
                              }).toList(),
                            ),
                          ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: CachedNetworkImage(
                                imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),


                        ]
                      ),

                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetail(
                      pokemonDetail: pokedex[index],
                      pokemonNumber: index + 1,
                      color: _getColorForType(types),
                      heroTag: index,
                    )));

                  },
                );
              },
              ),
             ),
            ],
        ),
          ),
        ]
      ),
    );
  }

  Future<void> fetchPokemonData() async {
    var url = Uri.https("pokeapi.co", "/api/v2/pokemon/");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedJsonData = jsonDecode(response.body);
      var pokemonList = decodedJsonData['results'];

      List<Map<String, dynamic>> updatedPokedex = [];

      for (var pokemon in pokemonList) {
        var pokemonUrl = Uri.parse(pokemon['url']);
        var pokemonResponse = await http.get(pokemonUrl);

        if (pokemonResponse.statusCode == 200) {
          var decodedPokemonData = jsonDecode(pokemonResponse.body);
          updatedPokedex.add({
            'name': pokemon['name'],
            'url': pokemon['url'],
            'types': decodedPokemonData['types'],
          });
        }
      }

      setState(() {
        pokedex = updatedPokedex;
      });
    }
  }

  Color _getColorForType(List<dynamic> types) {
    for (var type in types) {
      if (type['type']['name'] == 'fire') {
        return Colors.red;
      } else if (type['type']['name'] == 'water') {
        return Colors.blue;
      } else if (type['type']['name'] == 'grass') {
        return Colors.greenAccent;
      } else if (type['type']['name'] == 'electric') {
        return Colors.yellow;
      } else if (type['type']['name'] == 'rock') {
        return Colors.grey;
      } else if (type['type']['name'] == 'ground') {
        return Colors.brown;
      } else if (type['type']['name'] == 'physic') {
        return Colors.indigo;
      } else if (type['type']['name'] == 'normal') {
        return Colors.black54;
      } else if (type['type']['name'] == 'bug') {
        return Colors.lightGreenAccent;
      } else if (type['type']['name'] == 'ghost') {
        return Colors.deepPurple;
      } else if (type['type']['name'] == 'fighting') {
        return Colors.orange;
      }
    }
    return Colors.grey;
  }


}
