import 'package:cat_album_lab_flutter/model/CatAlbum.dart';
import 'package:cat_album_lab_flutter/controller/fetchCatAlbum.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<CatAlbum> futureCatAlbum;
  late int id = 1;
  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    futureCatAlbum = fetchCatAlbum(http.Client());
  }

  void refresh() => setState(() {
        futureCatAlbum = fetchCatAlbum(http.Client());
      });

  void nextCatAlbum() => setState(() {
        id++;
      });
  void previousCatAlbum() => setState(() {
        id--;
        if (id <= 0) {
          id = 1;
        }
      });
  List<Color> background = [
    Color.fromARGB(255, 2, 2, 2),
    Color.fromARGB(255, 83, 83, 83),
    Color.fromARGB(255, 236, 236, 236),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: background,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Center(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.only(top: 150, bottom: 20),
                child: Text(
                  'CatAlbum\nSearch',
                  style: titleStyle,
                )),
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
            navigationButtons()
          ]),
        ),
      ),
    );
  }

  Widget outputCard(String url) {

    return SizedBox(
      width: 300,
      height: 300,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.network(url),
      ),
    );
  }

  Widget navigationButtons() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {previousCatAlbum(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_left_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {nextCatAlbum(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_right_outlined),
            ),
          ),
        ]));
  }
}