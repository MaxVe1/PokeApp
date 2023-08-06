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
            return Scaffold (
            //backgroundColor: Colors.red,
            body: Column(
              children: [
                 Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                ), itemCount: aData.length,
                itemBuilder: (context, index){

    //var patientPhone;

  // Future<void> getPhone() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String patientPhone = await /*added */ prefs.getString('patientPhone');
  //   print(patientPhone);

  //   setState(() => _patientPhone = patientPhone);
  // }


  // void type() async{
  //         final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${index}/'));
  //         debugPrint('$res2.body');
  //         //return res2.body;
  //         var allData2 = json.decode(res2.body);
  //         //debugPrint("ZZZZZZZZZZz:${allData2}");
  //         var aa2=allData2["types"][0]["type"]["name"];
  //         debugPrint('ZZZZZZZZZZz:$aa2');
  //         //return aa2;
  //        //setState(() => patientPhone = res2.body);
  //        //return "NAMMETYPE";
  //        a2 = aa2;
  //        //debugPrint('111111111111:${a2[index]}');
  //        //return aa2;
  //       //  setState((){
  //       //  });
  // }
     
 


  //   fetch2() async{ 
  //  final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${index}/')); 
  //  //debugPrint('$res2.body'); 
  //  var allData2 = json.decode(res2.body);
  //  var a2=allData2["types"][0]["type"]["name"].toString();
  //  debugPrint(a2); 
  //  }
 

                         //type();
                         
                         return Card(
                                 color: Colors.green,
                                 child: Stack(
                                   children: [
                                   Positioned(
                                    bottom:85,
                                    left: 265,
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
                                     
                                    )                                                                   
                                   ),
                                   Positioned(
                                       bottom:55,
                                       left:280,
                                       child: Container(
                                         child: Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0, top:4, bottom: 4),
                                         child: Text( 
                                           //"Wait for text",
                                           a2[index].toString().capitalize(),
                                         // 'Text',
                                         // a2[index].toString(),
                                          //a2.toString(),
                                         //type().toString(),
                                         //aData[index]["name"],
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
//  final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/1/')); 
 //  debugPrint('$res2.body'); 
   //var allData2 = json.decode(res2.body);
   //var a2=allData2["types"][0]["type"]["name"];
   //debugPrint('$a2'); 
  if(res.statusCode == 200){
    //debugPrint('Res OK !!!'); 
    //debugPrint('$res.body'); 
    var allData = json.decode(res.body);
    //var 
    aData = allData["results"];
    debugPrint( '$aData' );
    //debugPrint( aData[0]["name"] );
    List res2 = [];
    List parsedListJson = [];
    List aa2  = [];
    for(int i=0;i<aData.length;i++){
          res2.add(await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${i+1}/')));       
          //debugPrint(res2[i].body);
         
          parsedListJson.add(json.decode(res2[i].body));
          aa2.add(parsedListJson[i]["types"][0]["type"]["name"]);
          //a2[item] = aa2.toString();
          debugPrint(aa2[i]);
          
           a2.add(aa2[i]);

           //a2.add(i);          
    }
    
   // var parsedListJson = jsonDecode(res2.body);
   // var aa2 = parsedListJson["types"][0]["type"]["name"];


    //List<String> itemsList = List<String>.from(parsedListJson.map<String>((dynamic i) => allData2.fromJson(i)));
    //debugPrint("$parsedListJson");
   // debugPrint("$aa2");

    //a2.add("aa2");
    //a2 = itemsList;
    setState((){
    });
  } 
  }

//   Future<String> token() async {
//   sharedPreferences = await SharedPreferences.getInstance();
//   return "Lorem ipsum dolor";
// }

// token().then((value) {
//   print(value);
// });


   void fetchPokeItem(item) async{

      // if(item == null) {
          final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${item}/'));  
          //debugPrint('$res2.body'); 
          //var allData2 = json.decode(res2.body);
          var parsedListJson = jsonDecode(res2.body);
          var aa2 = parsedListJson["types"][0]["type"]["name"];
          //a2[item] = aa2.toString();

          
          a2.add(aa2);
          //return aa2;
     //  }     
      //  else{
      //     final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${item+1}/')); 
      //     //final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/${item+1}/'));
      //     //debugPrint('$res2.body'); 
      //     //var allData2 = json.decode(res2.body);
      //     var parsedListJson = jsonDecode(res2.body);
      //     var aa2 = parsedListJson["types"][0]["type"]["name"];
      //     //debugPrint('Irem++++${aa2}++ ____${parsedListJson}_Index:${item}');

      //     debugPrint('_Index:${item}Irem++++${aa2}+');
      //     //a2[item] = aa2.toString();
      //     //a2.add(item);
      //     a2.add(aa2);
      //     //a2[0] = aa2;
      //     //a2.insert(a2.length-1, aa2);
      //     //a2 = parsedListJson["types"][0]["type"]["name"];
      //     //return "Some Text";//aa2;

           setState((){
           });
      //  }
           //return aa2;
       
  }
  
 



//   void type() async{
//     final res2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-form/1/')); 
     
//      //while(ind > 1){
//           debugPrint('$res2.body');
//           //return res2.body;
//           var allData2 = json.decode(res2.body);
//           //debugPrint("ZZZZZZZZZZz:${allData2}");
//          // var aa2=allData2["types"][0]["type"]["name"];
//          // debugPrint('ZZZZZZZZZZz:$aa2');
//           //return aa2;
//          //setState(() => patientPhone = res2.body);
//          //return "NAMMETYPE";
//           a2 = allData2["types"][0]["type"]["name"];

//        // List<MyModel> myModels;
// //var response = await http.get("myUrl");

// //myModels=(json.decode(response.body) as List).map((i) =>
//            //   MyModel.fromJson(i)).toList();

//             setState((){
//             });

//     // }
  }
  