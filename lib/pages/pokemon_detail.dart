import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({Key? key, this.pokemonNumber, this.pokemonDetail, this.heroTag, required this.color})
      : super(key: key);
  final Map<String, dynamic>? pokemonDetail;
  final int? pokemonNumber;
  final Color color;
  final heroTag;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 90,
            left: 20,
            child: Text(
              widget.pokemonDetail?['name'] ?? '',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 20,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                child: Text(
                  widget.pokemonDetail?['types']
                      .map((type) => type['type']['name'].toString())
                      .join(', '),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10),),
                color: Colors.black54
              ),
            ),
          ),          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: width * 0.3,
                            child: Text('Name:',
                            style: TextStyle(
                              fontSize: 18, color: Colors.blueGrey,
                            ),
                            )),
                        Container(
                            width: width * 0.3,
                            child: Text(widget.pokemonDetail?['name'] ?? '',style: TextStyle(
                              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold
                            ),)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: width * 0.3,
                            child: Text('Name:',
                              style: TextStyle(
                                fontSize: 18, color: Colors.blueGrey,
                              ),
                            )),
                        Container(
                            width: width * 0.3,
                            child: Text(widget.pokemonDetail?['evolution_details'] ?? '',style: TextStyle(
                                fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold
                            ),)),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            left: (width / 2) - 100,
            child: CachedNetworkImage(
              imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.pokemonNumber}.png',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}

