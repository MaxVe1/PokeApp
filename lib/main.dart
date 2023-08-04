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

class _HomeScreenState extends State<HomeScreen> {
  var url = 'https://pokeapi.co/api/v2/pokemon';
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
                                 child: Text( 
                                  aData[index]["name"]
                                  ),
                         );
                          
                },
              ))
              ],
            )
      );
                    
  }



  void fetchPokeData() async{

  
  final res = await http.get(Uri.parse(url)); 
  
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
