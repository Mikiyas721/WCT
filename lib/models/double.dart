import '../core/jsonModel.dart';

class DoubleModel extends JSONModel<double> {
  final double data;

  DoubleModel({this.data}) : super(data);

  @override
  Map<String, dynamic> toMap() {
    return {'data': data};
  }

  factory DoubleModel.fromMap(Map<String, dynamic> map) {
    return DoubleModel(data: map['data']);
  }
}
