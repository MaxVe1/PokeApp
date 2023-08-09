import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:poke_app/poke_details.dart';

 void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override 
  _HomeScreenState createState() => _HomeScreenState();
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}

class _HomeScreenState extends State<HomeScreen> {
  var url ='https://pokeapi.co/api/v2/pokemon?offset=0&limit=50';
  List pokeNames = [];
  var pokeTypes  = [];
  List pokeHeightArr = [];
  List pokeWeightArr = [];

  @override
  void initState(){

    super.initState();
    if(mounted){
       fetchPokeData();       
    }
  } 

  @override 
  Widget build(BuildContext context) {
          if(pokeNames.length != 0){
          var width = MediaQuery.of(context).size.width;          
          return Scaffold (  
            // appBar: AppBar(
            //          title: Text('Welcome to PokeApp'),
            // ),          
            body: Stack(
              children: [           
                Positioned(
                  top: 100,
                  left: 20,
                  child: Text("PokeApp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),)
                ),
                Positioned(
                top:150,
                bottom:0,
                width: width,          
                child: Column(
                children: [
                 Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                ), itemCount: pokeNames.length,
                itemBuilder: (context, index){
                         return InkWell(
                         child:  Padding(
                         padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 8),
                         child: Container(
                                 //color: Colors.green,
                                 decoration: BoxDecoration(
                                  color: pokeTypes[index] == "grass" ? Colors.greenAccent
                                       : pokeTypes[index] == "fire" ? Colors.redAccent 
                                       : pokeTypes[index] == "water" ? Colors.blue
                                       : pokeTypes[index] == "electric" ? Colors.yellow
                                       : pokeTypes[index] == "rock" ? Colors.grey
                                       : pokeTypes[index] == "ground" ? Colors.brown
                                       : pokeTypes[index] == "psychic" ? Colors.indigo
                                       : pokeTypes[index] == "fighting" ? Colors.orange
                                       : pokeTypes[index] == "bug" ? Colors.lightGreenAccent
                                       : pokeTypes[index] == "ghost" ? Colors.deepPurple
                                       : pokeTypes[index] == "normal" ? Colors.black26
                                       : pokeTypes[index] == "fairy" ? Colors.limeAccent
                                       : Colors.pink,
                                  //Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                 ),
                                 child: Stack(
                                   children: [                             
                                   Positioned(
                                    bottom:20,
                                    left: 10,
                                    child: Text( 
                                        pokeNames[index]["name"].toString().capitalize(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 12,
                                          color: Colors.white,
                                          ),
                                       ),
                                   ),
                                   Positioned(
                                    top:15,
                                    left:75,
                                    child: CircleAvatar(
                                    backgroundImage:
                                    NetworkImage('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png'),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                     
                                    )                                                                   
                                   ),
                                   Positioned(
                                       bottom:50,
                                       left:7,
                                       child: Container(
                                         child: Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0, top:4, bottom: 4),
                                         child: Text(                                           
                                           pokeTypes[index].toString().capitalize(),
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
                                   ],                                                    
                                 ),
                         ),
                         ),
                         onTap: (){
                          //ToDo Navigate to new detail screen
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PokeDetails(
                           pokeDetail: pokeNames[index]["name"].toString().capitalize(),
                           pokeHeight: pokeHeightArr[index].toString(),
                           pokeWeight: pokeWeightArr[index].toString(),
                           pokeType: pokeTypes[index].toString().capitalize(),
                           pokeImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png",
                           color: pokeTypes[index] == "grass" ? Colors.greenAccent
                                       : pokeTypes[index] == "fire" ? Colors.redAccent 
                                       : pokeTypes[index] == "water" ? Colors.blue
                                       : pokeTypes[index] == "electric" ? Colors.yellow
                                       : pokeTypes[index] == "rock" ? Colors.grey
                                       : pokeTypes[index] == "ground" ? Colors.brown
                                       : pokeTypes[index] == "psychic" ? Colors.indigo
                                       : pokeTypes[index] == "fighting" ? Colors.orange
                                       : pokeTypes[index] == "bug" ? Colors.lightGreenAccent
                                       : pokeTypes[index] == "ghost" ? Colors.deepPurple
                                       : pokeTypes[index] == "normal" ? Colors.black26
                                       : pokeTypes[index] == "fairy" ? Colors.limeAccent
                                       : Colors.pink,
                           heroTag: index
                          )));
                         },
                         );                         
                },
                ),
              )          
              ],
              )
              )],
            )
          );
           } else{
                 return Scaffold(
                  appBar: AppBar(
                     title: Text('PokeApp: Please wait for updating data ...'),
                  ),
                  body: Stack(
                  children: [                         
                     Positioned(
                     child: Center(
                     child:  CircularProgressIndicator(
                     backgroundColor: Colors.cyanAccent,
                     valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                     ),                     
                  ),                                
                  ),        
                  ]),
           );
    }                   
  }
  void fetchPokeData() async{
  
  final res = await http.get(Uri.parse(url)); 

  if(res.statusCode == 200){
   
    var allData = json.decode(res.body);
   
    pokeNames = allData["results"];
    //debugPrint( '$pokeNames' );
   
    List res2 = [];
    List parsedListJson = [];
    List aa2  = [];

    List resHeightW = [];
    List parsedHWJson = [];

    for(int i=0;i< pokeNames.length;i++){
          res2.add(await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${i+1}/')));       
              
          parsedListJson.add(json.decode(res2[i].body));
          aa2.add(parsedListJson[i]["types"][0]["type"]["name"]);          
                  
          pokeTypes.add(aa2[i]);

          resHeightW.add(await http.get(Uri.parse(('https://pokeapi.co/api/v2/pokemon/${i+1}/'))));           
          parsedHWJson.add(json.decode(resHeightW[i].body)); 
          pokeHeightArr.add(parsedHWJson[i]["height"]); 
          pokeWeightArr.add(parsedHWJson[i]["weight"]);          
    }
  
    setState((){
    });
  } 
  }
  }
  