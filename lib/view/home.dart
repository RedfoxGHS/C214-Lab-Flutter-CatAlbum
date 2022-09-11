import 'dart:convert';

import 'package:cat_album_lab_flutter/controller/user_data_controller.dart';
import 'package:cat_album_lab_flutter/model/cat_album.dart';
import 'package:cat_album_lab_flutter/controller/fetch_cat_album.dart';
import 'package:cat_album_lab_flutter/model/user_data.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<CatAlbum> futureCatAlbum;
  late Future<UserData> futureUserData;
  UserData userData = UserData();

  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    futureCatAlbum = fetchCatAlbum(http.Client());
    futureUserData = getUserData();
    futureUserData.then((value){
      value.incrementNumberOfPhotosSeen();
      userData = value;
    });

  }


  void refresh() => setState(() {
    futureCatAlbum = fetchCatAlbum(http.Client());
    futureUserData.then((value){
      value.incrementNumberOfPhotosSeen();
      userData = value;
    });
    saveData(userData);
  });


  List<Color> background = [
    Color.fromARGB(255, 2, 2, 2),
    Color.fromARGB(255, 172, 172, 172),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fotos Aleatorias de Gatinhos'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: background,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Center(
          child: Column(children: [
            FutureBuilder<CatAlbum>(
              future: futureCatAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return outputCard(
                      snapshot.data!.url,
                     );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            navigationButtons(),
            FutureBuilder<UserData>(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListBody(
                    children: [
                      outputInfo("Nome", snapshot.data!.name),
                      outputInfo("Quantidade de Fotos Vizualizadas" ,snapshot.data!.numberOfPhotosSeen.toString()),
                      outputInfo("Quantidade de Fotos Salvas", snapshot.data!.numberOfPhotosSave.toString())]
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            
          ]),
        ),
      ),
    );
  }

  Widget outputCard(String url) {

    return SizedBox(
      width: double.infinity,
      height: 400,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.network(url),
      ),
    );
  }

  Widget outputInfo(String title, String info) {
    return Padding(
      padding:  const EdgeInsets.only(left: 20),
      child:Text(
              "$title: $info",
              style: const TextStyle(
                height: 1.2,
                fontSize: 15,
                color: Colors.white
              ),
            )
      );
    
 
  }

  Widget navigationButtons() {
    return  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            child: FloatingActionButton(
              onPressed: () => {refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.replay_rounded),
            ),
          ),
        ]);
  }

}