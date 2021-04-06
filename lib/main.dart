//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:uts_skincare/home.dart';
import 'home.dart';
import 'home2.dart';


 //package letak folder Anda

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("````SKINCAREKU````"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Produk",
                  ),
                Tab(
                  text : "Kategori"
                ),
              ],
            ),
          ),
              body: TabBarView(
                children: [
                  Home(),
                  Home2(),
                ],
              ),
          ),
        ),
    );
  }
}
