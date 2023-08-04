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
            backgroundColor: Colors.red,
            body: Center(
              child: ElevatedButton(
                child: Text('Press Button'),
                onPressed:  (){
                    fetchPokeData();
                },
              ),
            ),
           );

            
  }



  void fetchPokeData() async{

  var url = 'https://pokeapi.co/api/v2/pokemon';
  final res = await http.get(Uri.parse(url)); 
  
  if(res.statusCode == 200){
    debugPrint('Res OK !!!'); 
    //debugPrint('$res.body'); 

    var allData = json.decode(res.body);
    var aData = allData["results"];

    //debugPrint( '$aData' );
    debugPrint( aData[0]["name"] );
    setState((){

    });
  }
    //var url = Uri.http(url);
  //http.get(url).then((val) => {
     //      debugPrint('$val.statusCode')
   // });
  }
}
