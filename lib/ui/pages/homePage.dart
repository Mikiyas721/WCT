import 'package:flutter/material.dart';
import 'package:wct/ui/customWidgets/myFloatingActionButton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WNT'),
      ),
      body: null,
      floatingActionButton: FancyFab(),
    );
  }
}
