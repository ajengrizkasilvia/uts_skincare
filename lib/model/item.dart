class Item {
  int _id;
  String _name;
  String _brand;
  int _price;
  String _kode;
  int _stok;

  int get id => _id;

  String get name => this._name;
  set name(String value) => this._name = value;

  String get brand => this._brand;
  set brand(String value) => this._brand = value;

  get price => this._price;
  set price(value) => this._price = value;

  String get kode => this._kode;
  set kode(String value) => this._kode = value;

  get stok => this._stok;
  set stok(value) => this._stok = value;

// konstruktor versi 1
  Item(this._name,this._brand, this._price, this._kode, this._stok);

// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._brand = map['brand'];
    this._price = map['price'];
    this._kode = map['kode'];
    this._stok = map['stok'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['brand'] = brand;
    map['price'] = price;
    map['kode'] = kode;
    map['stok'] = stok;
    return map;
  }
}
