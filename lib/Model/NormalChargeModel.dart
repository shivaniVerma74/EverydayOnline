/// error : false
/// message : "Delivery Fee Found!"
/// Charge : [{"id":"1","min_km":"0","max_km":"5","delivery_charge":"30"},{"id":"2","min_km":"1","max_km":"15","delivery_charge":"100"}]

class NormalChargeModel {
  NormalChargeModel({
      bool? error, 
      String? message, 
      List<Charge>? charge,}){
    _error = error;
    _message = message;
    _charge = charge;
}

  NormalChargeModel.fromJson(dynamic json) {
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
NormalChargeModel copyWith({  bool? error,
  String? message,
  List<Charge>? charge,
}) => NormalChargeModel(  error: error ?? _error,
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
/// min_km : "0"
/// max_km : "5"
/// delivery_charge : "30"

class Charge {
  Charge({
      String? id, 
      String? minKm, 
      String? maxKm, 
      String? deliveryCharge,}){
    _id = id;
    _minKm = minKm;
    _maxKm = maxKm;
    _deliveryCharge = deliveryCharge;
}

  Charge.fromJson(dynamic json) {
    _id = json['id'];
    _minKm = json['min_km'];
    _maxKm = json['max_km'];
    _deliveryCharge = json['delivery_charge'];
  }
  String? _id;
  String? _minKm;
  String? _maxKm;
  String? _deliveryCharge;
Charge copyWith({  String? id,
  String? minKm,
  String? maxKm,
  String? deliveryCharge,
}) => Charge(  id: id ?? _id,
  minKm: minKm ?? _minKm,
  maxKm: maxKm ?? _maxKm,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
);
  String? get id => _id;
  String? get minKm => _minKm;
  String? get maxKm => _maxKm;
  String? get deliveryCharge => _deliveryCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['min_km'] = _minKm;
    map['max_km'] = _maxKm;
    map['delivery_charge'] = _deliveryCharge;
    return map;
  }

}