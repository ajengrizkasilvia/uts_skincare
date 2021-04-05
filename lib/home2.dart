import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_skincare/dbhelper.dart';
import 'package:uts_skincare/entryformKategori.dart';
import 'package:uts_skincare/model/kategori.dart';
import 'dart:async';

//pendukung program asinkron
class Home2 extends StatefulWidget {
  @override
  Home2State createState() => Home2State();
}

class Home2State extends State<Home2> {
  DbHelper dbHelper = DbHelper(); //memanggil kls dbhelp
  int count = 0;
  List<Kategori> kategoriList; //dekl list
  @override
  Widget build(BuildContext context) {
    if (kategoriList == null) {
      kategoriList = List<Kategori>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Skincare'),
      ),
      body: Column(children: [
        Expanded( //memperluas children ke tempat yg terpisah
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity, //button sampai terpinggir
            child: RaisedButton(
              child: Text("Tambah Kategori"),
              onPressed: () async { //tdk menunggu proses
                var kategori = await navigateToEntryForm(context, null);
                if (kategori != null) { //jika terisi maka akan diinsert
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertKat(kategori);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Kategori> navigateToEntryForm(BuildContext context, Kategori kategori) async { 
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormKategori(kategori);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card( 
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ), //untuk icon hp
            title: Text(
              this.kategoriList[index].kategori,
              style: textStyle,
            ),
            subtitle: Text(this.kategoriList[index].tipewajah),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Kategori
              int result = await dbHelper.deleteKat(this.kategoriList[index].id);
                if (result > 0){
                  updateListView();
                }
              },
            ),
            onTap: () async {
              var kategori =
                  await navigateToEntryForm(context, this.kategoriList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
                int result = await dbHelper.updateKat(kategori);
                if (result > 0){
                  updateListView();
                }
            },
          ),
        );
      },
    );
  }

  //update List kategori
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Kategori>> kategoriListFuture = dbHelper.getKategoriList();
      kategoriListFuture.then((kategoriList) {
        setState(() {
          this.kategoriList = kategoriList;
          this.count = kategoriList.length;
        });
      });
    });
  }
}
