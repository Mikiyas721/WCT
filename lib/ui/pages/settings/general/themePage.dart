import '../../../../bloc/provider/provider.dart';
import '../../../../bloc/themeBloc.dart';
import '../../../../resources/myThemeData.dart';
import '../../../customWidgets/circularContainer.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        blocFactory: () => ThemeBloc(),
        builder: (BuildContext context, ThemeBloc bloc) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Theme",
              ),
            ),
            body: ListView(
              children: <Widget>[
                StreamBuilder(
                    stream: bloc.themeRepo.themeDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        leading: CircularContainer(
                            backgroundColor:
                                MyThemeData.defaultLight.primaryColor),
                        title: Text(
                          "Light",
                          style: Theme.of(context).textTheme.body2,
                        ),
                        trailing: snapshot.data == MyThemeData.defaultLight
                            ? getMarkedIcon()
                            : null,
                        onTap: () async {
                          await bloc.changeTheme("DefaultLight");
                        },
                      );
                    }),
                StreamBuilder(
                    stream: bloc.themeRepo.themeDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        leading: CircularContainer(
                            backgroundColor:
                                MyThemeData.defaultDark.primaryColor),
                        title: Text(
                          "Dark",
                          style: Theme.of(context).textTheme.body2,
                        ),
                        trailing: snapshot.data == MyThemeData.defaultDark
                            ? getMarkedIcon()
                            : null,
                        onTap: () async {
                          await bloc.changeTheme("DefaultDark");
                        },
                      );
                    }),
                StreamBuilder(
                    stream: bloc.themeRepo.themeDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        leading: CircularContainer(
                            backgroundColor: MyThemeData.darkBlue.primaryColor),
                        title: Text(
                          "Dark Blue",
                          style: Theme.of(context).textTheme.body2,
                        ),
                        trailing: snapshot.data == MyThemeData.darkBlue
                            ? getMarkedIcon()
                            : null,
                        onTap: () async {
                          await bloc.changeTheme("DarkBlue");
                        },
                      );
                    }),
                StreamBuilder(
                    stream: bloc.themeRepo.themeDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        leading: CircularContainer(
                            backgroundColor:
                                MyThemeData.defaultLerp.primaryColor),
                        title: Text(
                          "Lerp",
                          style: Theme.of(context).textTheme.body2,
                        ),
                        trailing: snapshot.data == MyThemeData.defaultLerp
                            ? getMarkedIcon()
                            : null,
                        onTap: () async {
                          await bloc.changeTheme("DefaultLerp");
                        },
                      );
                    }),
              ],
            ),
          );
        });
  }

  Icon getMarkedIcon() {
    return Icon(
      Icons.check,
      color: Colors.blue,
    );
  }
}
