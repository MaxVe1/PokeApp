import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  //var url = 'https://pokeapi.co/api/v2/pokemon';
  var url ='https://pokeapi.co/api/v2/pokemon?offset=0&limit=100';
  var url2='https://pokeapi.co/api/v2/pokemon-form/1/';
  List aData = [];
  var a2  = [];

  @override
  void initState(){

    super.initState();
    if(mounted){
       fetchPokeData();       
    }
  } 

  @override 
  Widget build(BuildContext context) {
          if(aData.length != 0){
          var width = MediaQuery.of(context).size.width;
          //var height = MediaQuery.of(context).size.height;
          return Scaffold (            
            body: Stack(
              children: [
                // Image for Pokeball (Optional)
                // Positioned(
                // top:-50,
                // right:-50,
                // child: //NetworkImage(''),
                // Image.asset('images/pokemon.png',
                // width: 200, fit: BoxFit.fitWidth,
                // )
                // ),
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
                ), itemCount: aData.length,
                itemBuilder: (context, index){
                         return Padding(
                         padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 8),
                         child: Container(
                                 //color: Colors.green,
                                 decoration: BoxDecoration(
                                  color: a2[index] == "grass" ? Colors.greenAccent
                                       : a2[index] == "fire" ? Colors.redAccent 
                                       : a2[index] == "water" ? Colors.blue
                                       : a2[index] == "electric" ? Colors.yellow
                                       : a2[index] == "rock" ? Colors.grey
                                       : a2[index] == "ground" ? Colors.brown
                                       : a2[index] == "psychic" ? Colors.indigo
                                       : a2[index] == "fighting" ? Colors.orange
                                       : a2[index] == "bug" ? Colors.lightGreenAccent
                                       : a2[index] == "ghost" ? Colors.deepPurple
                                       : a2[index] == "normal" ? Colors.black26
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
                                        aData[index]["name"].toString().capitalize(),
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
                                           a2[index].toString().capitalize(),
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


                         );
                         
                },
                ),
              )          
              ],
              )

              ) //<==Column 51:15
              ],
            )
          );
           } else{
                 return Scaffold(
                  
       appBar: AppBar(
         title: Text('Please wait for updating data'),
       ),
       body: Center(
         child:  CircularProgressIndicator(
         backgroundColor: Colors.cyanAccent,
         valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
         ),
        ),
     );
    }                   
  }
  void fetchPokeData() async{
  
  final res = await http.get(Uri.parse(url)); 

  if(res.statusCode == 200){
   
    var allData = json.decode(res.body);
   
    aData = allData["results"];
    debugPrint( '$aData' );
   
    List res2 = [];
    List parsedListJson = [];
    List aa2  = [];
    for(int i=0;i<aData.length;i++){
          res2.add(await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${i+1}/')));       
              
          parsedListJson.add(json.decode(res2[i].body));
          aa2.add(parsedListJson[i]["types"][0]["type"]["name"]);          
          debugPrint(aa2[i]);          
          a2.add(aa2[i]);
                   
    }
  
    setState((){
    });
  } 
  }
  }
  