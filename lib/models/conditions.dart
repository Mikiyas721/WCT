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

  int getAgeConstant() {
    int age;
    try {
      age = int.parse(data);
      if (age < 30)
        return 40;
      else if (age >= 30 && age < 55) return 35;
      else return 30;
    } catch (Exception) {
      throw Error.safeToString(Exception);
    }
  }
}
