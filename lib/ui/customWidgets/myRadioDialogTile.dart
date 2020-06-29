import 'package:Nutracker/ui/customWidgets/mySettingItem.dart';
import 'package:Nutracker/ui/customWidgets/radioDialog.dart';
import 'package:flutter/material.dart';

class MyRadioDialogTile extends StatelessWidget {
  final String title;
  final List<String> options;
  final String trailing;
  final int groupValue;
  final Function onSubmit;
  final IconData leadingIcon;

  MyRadioDialogTile({
    @required this.title,
    @required this.options,
    @required this.trailing,
    @required this.groupValue,
    @required this.onSubmit,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MySettingItem(
      title: title,
      leadingIcon: leadingIcon,
      trailing: trailing,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RadioDialog(title, groupValue, options,
                  onSubmit: onSubmit);
            });
      },
    );
  }
}
