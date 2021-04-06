import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_skincare/dbhelper.dart';
import 'package:uts_skincare/entryform.dart';
import 'dart:async';
import 'model/item.dart'; 

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper(); //memanggil kls dbhelp
  int count = 0;
  List<Item> itemList; //dekl list
  @override
  void initState() {
    super.initState();
    updateListView();
  }
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Skincare'),
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
              child: Text("Tambah Item"),
              onPressed: () async { //tdk menunggu proses
                var item = await navigateToEntryForm(context, null);
                if (item != null) { //jika terisi maka akan diinsert
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
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

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async { 
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
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
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.face_retouching_natural),
            ), //untuk icon hp
            title: 
              Text(
                this.itemList[index].name,
                style: textStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.itemList[index].brand),
                Text(this.itemList[index].price.toString()),
                Text(this.itemList[index].stok.toString()),
              ]
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
              int result = await dbHelper.delete(this.itemList[index].id);
                if (result > 0){
                  updateListView();
                }
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
                int result = await dbHelper.update(item);
                if (result > 0){
                  updateListView();
                }
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
