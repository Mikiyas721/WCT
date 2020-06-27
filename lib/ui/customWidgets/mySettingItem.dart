import 'package:flutter/material.dart';

class MySettingItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Function onTap;

  MySettingItem(
      {@required this.leadingIcon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
      ),
      title: Text(
        title,
      ),
      onTap: onTap,
    );
  }
}
