import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget{
  final pokeDetail;
  final pokeImage;
  final color;
  final heroTag;
  //final key;

  const PokeDetails( {
    //Key key, 
    this.pokeDetail, this.color, this.heroTag , this.pokeImage});
    // : super(key: key);
  
  @override
  _PokeDetailsState createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
   @override
   Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: widget.color,
        body: Stack(
          children: [
            Positioned(  
                top:45,
                left: 10,
                child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                onPressed: (){
                  Navigator.pop(context);
                },)                 
            ), 
            Positioned(
                top: 100,
                left: 20,                    
                child: Text(widget.pokeDetail,
                style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30
                    ),
                  )
            ),
            Positioned(
                bottom: 0,
                child: Container(
                   width: width,
                   height: height * 0.6,
                   decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      color: Colors.white
                   ),
                ),
            ),
            Positioned(
                top: 80,
                //left: width / 2, 
                right:30,               
                child: CircleAvatar(
                     backgroundImage: NetworkImage(widget.pokeImage),
                     radius: 45,
                     backgroundColor: Colors.white,
                )
                ),
           ],
        ),
      );
   }
}
