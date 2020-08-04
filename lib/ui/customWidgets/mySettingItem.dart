import 'package:flutter/material.dart';

class MySettingItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final void Function() onTap;
  final bool enabled;
  final String trailing;

  MySettingItem({
    @required this.title,
    this.leadingIcon,
    this.onTap,
    this.trailing,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: leadingIcon==null?null:Icon(
        leadingIcon,
      ),
      title: Text(
        '$title',
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: TextStyle(color: Colors.blue),
            )
          : null,
      onTap: onTap,
    );
  }
}
