import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget{
  final pokeDetail;
  final pokeType;
  final pokeImage;
  final color;
  final heroTag;

  //final pokeHeight;
  //final pokeWeight;
  //final key;

  const PokeDetails( {
    //Key key, 
    this.pokeDetail, this.pokeType, this.color, this.heroTag , this.pokeImage, /*this.pokeHeight, this.pokeWeight*/});
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
              top: 140,
              left: 20,
              child: Container(
              child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0, top:4, bottom: 4),
              child: Text(                                           
              widget.pokeType,
              style: TextStyle(
              color: Colors.white
              ),
              ),
              ), 
              decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black26,                                         
              ),                       
                                    
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                   width: width,
                   height: height * 0.65,
                   decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      color: Colors.white
                   ),
                   child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                   SizedBox(height: 30,),                 
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,    
                   children: [
                    Container(
                                 width: width * 0.4, 
                                 child: Text("Name", style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17,
                                 ),),
                           ),
                           Container(
                                 width: width * 0.45, 
                                 child: Text(widget.pokeDetail, style: TextStyle(
                                  color: Colors.black, fontSize: 17,
                                  fontWeight: FontWeight.bold
                                 ),),
                           ),
                      ])
                   ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,    
                   children: [
                    Container(
                                 width: width * 0.4, 
                                 child: Text("Type", style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17,
                                 ),),
                           ),
                           Container(
                                 width: width * 0.45, 
                                 child: Text(widget.pokeType, style: TextStyle(
                                  color: Colors.black, fontSize: 17,
                                  fontWeight: FontWeight.bold
                                 ),),
                           ),
                      ])
                   ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,    
                   children: [
                    Container(
                                 width: width * 0.4, 
                                 child: Text("Weight", style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17,
                                 ),),
                           ),
                           Container(
                                 width: width * 0.45, 
                                 child: Text("XX.X Cm", style: TextStyle(
                                  color: Colors.black, fontSize: 17,
                                  fontWeight: FontWeight.bold
                                 ),),
                           ),
                      ])
                   ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,    
                   children: [
                    Container(
                                 width: width * 0.4, 
                                 child: Text("Height", style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17,
                                 ),),
                           ),
                           Container(
                                 width: width * 0.45, 
                                 child: Text("XX.X Kg", style: TextStyle(
                                  color: Colors.black, fontSize: 17,
                                  fontWeight: FontWeight.bold
                                 ),),
                           ),
                      ])
                   )
                    ],
                   ),      
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
