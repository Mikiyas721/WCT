import 'package:equatable/equatable.dart';

abstract class Mappable {
  Map<String, dynamic> toMap();
}

abstract class JSONModel extends Equatable implements Mappable {
  final String id;

  const JSONModel(this.id);

  @override
  List<Object> get props => [id];

  static DateTime createdFromMap(map) {
    final d = map['createdAt'];
    if (d != null) return DateTime.parse(d);
    return DateTime.now();
  }

  static DateTime updatedFromMap(map) {
    final d = map['updatedAt'];
    if (d != null) return DateTime.parse(d);
    return DateTime.now();
  }
}
