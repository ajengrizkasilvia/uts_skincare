class Kategori {
  int _id;
  String _kategori;
  String _tipewajah;

  int get id => _id;

  String get kategori => this._kategori;
  set kategori(String value) => this._kategori = value;

  String get tipewajah => this._tipewajah;
  set tipewajah(String value) => this._tipewajah = value;

// konstruktor versi 1
  Kategori(this._kategori, this._tipewajah );

// konstruktor versi 2: konversi dari Map ke Item
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kategori = map['kategori'];
    this._tipewajah = map['tipewajah'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kategori'] = kategori;
    map['tipewajah'] = tipewajah;
    return map;
  }
}
