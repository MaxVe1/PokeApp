import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget{
  final pokeDetail;
  final color;
  final heroTag;
  //final key;

  const PokeDetails( {
    //Key key, 
    this.pokeDetail, this.color, this.heroTag});
    // : super(key: key);
  
  @override
  _PokeDetailsState createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
   @override
   Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: widget.color,
        body: Stack(
             children: [
                Positioned(                  
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    onPressed: (){
                    Navigator.pop(context);
                    }, )                 
                  ),
             ],
        ),
        //Colors.red,
    );
   }
}
