import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
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
// void main() {
//    runApp(HomeScreen());
//  }
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

  @override
  void initState(){

    super.initState();
    if(mounted){
       fetchPokeData();
    }
  } 

  @override 
  Widget build(BuildContext context){
           if(aData.length != 0){
            return Scaffold(
            //backgroundColor: Colors.red,
            body: Column(
              children: [
                 Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                ), itemCount: aData.length,
                itemBuilder: (context, index){

                         return Card(
                                 color: Colors.green,
                                 child: Stack(
                                   children: [
                                   Positioned(
                                    bottom:85,
                                    left:270,
                                    child: Text( 
                                        aData[index]["name"].toString().capitalize(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18,
                                          color: Colors.white,
                                          ),
                                       ),
                                   ),
                                   Positioned(
                                    top:90,
                                    left:190,
                                    child: CircleAvatar(
                                    backgroundImage:
                                    NetworkImage('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png'),
                                    radius: 120,
                                    backgroundColor: Colors.white,
                                    //Image(image: NetworkImage("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png")),
                                    )                                                                   
                                   ),
                                   Positioned(
                                       bottom:55,
                                       left:272,
                                       child: Container(
                                         child: Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0, top:4, bottom: 4),
                                         child: Text( 
                                         aData[index]["name"],
                                         style: TextStyle(
                                          color: Colors.white
                                         ),
                                        //decoration: BoxDecoration
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
                         );
                },
                ),
              )          
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
  //final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${index}/')); 
  if(res.statusCode == 200){
    debugPrint('Res OK !!!'); 
    //debugPrint('$res.body'); 

    var allData = json.decode(res.body);
    //var 
    aData = allData["results"];

    //debugPrint( '$aData' );
    debugPrint( aData[0]["name"] );
    setState((){

    });
  }   
  }
}
