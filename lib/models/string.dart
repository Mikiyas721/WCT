import '../core/jsonModel.dart';

class StringModel extends JSONModel<String> {
  final String data;

  StringModel({this.data}) : super(data);

  @override
  Map<String, dynamic> toMap() {
    return {'data': data};
  }

  factory StringModel.fromMap(Map<String, dynamic> map) {
    return StringModel(data: map['data']);
  }
}
