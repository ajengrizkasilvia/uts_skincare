import 'package:flutter/material.dart';
import 'model/kategori.dart';

class EntryFormKategori extends StatefulWidget {
  final Kategori kategori;
  EntryFormKategori(this.kategori);

  @override
  EntryFormKategoriState createState() => EntryFormKategoriState(this.kategori);
}

//class controller
class EntryFormKategoriState extends State<EntryFormKategori> {
  Kategori kategori;
  EntryFormKategoriState(this.kategori);
  TextEditingController kategoriController = TextEditingController();
  TextEditingController tipewajahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (kategori != null) {
      kategoriController.text = kategori.kategori;
      tipewajahController.text = kategori.tipewajah;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: kategori == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // kategori
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kategoriController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kategori Skincare',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tipe wajah
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kategoriController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Tipe Wajah',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (kategori== null) {
                            // tambah data
                            kategori = Kategori(
                                kategoriController.text,
                                tipewajahController.text);
                          } else {
                            // ubah data
                            kategori.kategori = kategoriController.text;
                            kategori.tipewajah = tipewajahController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek kategori
                          Navigator.pop(context, kategori);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}