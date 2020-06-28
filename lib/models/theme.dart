import '../core/jsonModel.dart';
import '../resources/myThemeData.dart';
import 'package:flutter/material.dart';

class ThemeModel extends JSONModel{
  final String name;

  ThemeModel({this.name}):super(name);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name':name
    };
  }

  factory ThemeModel.fromMap(Map<String,dynamic> map){
    return ThemeModel(name:map['name']);
  }

  ThemeData get generateTheme{
    if(this.name=="DefaultDark") return MyThemeData.defaultDark;
    else if(this.name=="DefaultLerp") return MyThemeData.defaultLerp;
    else if(this.name=="DarkBlue") return MyThemeData.darkBlue;
    else return MyThemeData.defaultLight;
  }
}