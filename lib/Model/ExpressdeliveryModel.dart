/// error : false
/// message : "Delivery Fee Found!"
/// Charge : [{"id":"1","fee":"50","status":"1"}]

class ExpressdeliveryModel {
  ExpressdeliveryModel({
      bool? error, 
      String? message, 
      List<Charge>? charge,}){
    _error = error;
    _message = message;
    _charge = charge;
}

  ExpressdeliveryModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['Charge'] != null) {
      _charge = [];
      json['Charge'].forEach((v) {
        _charge?.add(Charge.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Charge>? _charge;
ExpressdeliveryModel copyWith({  bool? error,
  String? message,
  List<Charge>? charge,
}) => ExpressdeliveryModel(  error: error ?? _error,
  message: message ?? _message,
  charge: charge ?? _charge,
);
  bool? get error => _error;
  String? get message => _message;
  List<Charge>? get charge => _charge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_charge != null) {
      map['Charge'] = _charge?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// fee : "50"
/// status : "1"

class Charge {
  Charge({
      String? id, 
      String? fee, 
      String? status,}){
    _id = id;
    _fee = fee;
    _status = status;
}

  Charge.fromJson(dynamic json) {
    _id = json['id'];
    _fee = json['fee'];
    _status = json['status'];
  }
  String? _id;
  String? _fee;
  String? _status;
Charge copyWith({  String? id,
  String? fee,
  String? status,
}) => Charge(  id: id ?? _id,
  fee: fee ?? _fee,
  status: status ?? _status,
);
  String? get id => _id;
  String? get fee => _fee;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fee'] = _fee;
    map['status'] = _status;
    return map;
  }

}