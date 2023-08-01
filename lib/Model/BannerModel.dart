/// error : false
/// data : [{"id":"1","image":"https://developmentalphawizz.com/everyday_online/uploads/media/2022/canopic-jars,-ancient-egyptian-artifacts.jpg","date_added":"2023-03-16 12:13:42"},{"id":"2","image":"https://developmentalphawizz.com/everyday_online/uploads/media/2022/canopic-jars,-ancient-egyptian-artifacts.jpg","date_added":"2023-03-16 12:24:06"},{"id":"3","image":"https://developmentalphawizz.com/everyday_online/uploads/media/2022/canopic-jars,-ancient-egyptian-artifacts.jpg","date_added":"2023-03-16 12:24:10"}]

class BannerModel {
  BannerModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  BannerModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
BannerModel copyWith({  bool? error,
  List<Data>? data,
}) => BannerModel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// image : "https://developmentalphawizz.com/everyday_online/uploads/media/2022/canopic-jars,-ancient-egyptian-artifacts.jpg"
/// date_added : "2023-03-16 12:13:42"

class Data {
  Data({
      String? id, 
      String? image, 
      String? dateAdded,}){
    _id = id;
    _image = image;
    _dateAdded = dateAdded;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _dateAdded = json['date_added'];
  }
  String? _id;
  String? _image;
  String? _dateAdded;
Data copyWith({  String? id,
  String? image,
  String? dateAdded,
}) => Data(  id: id ?? _id,
  image: image ?? _image,
  dateAdded: dateAdded ?? _dateAdded,
);
  String? get id => _id;
  String? get image => _image;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['date_added'] = _dateAdded;
    return map;
  }

}