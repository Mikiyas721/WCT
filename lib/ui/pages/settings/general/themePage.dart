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
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Create New Theme",
                      style: Theme.of(context).textTheme.body2,
                    )),
                Card(
                  margin: EdgeInsets.all(0),
                  shape: BeveledRectangleBorder(),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Text(
                        "You can create your own theme by changing the colors within the app. You can always switch back to the default Telegraph theme here.",
                        style: Theme.of(context).textTheme.caption,
                      )),
                ),
                StreamBuilder(
                    stream: bloc.themeRepo.themeDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListTile(
                        leading: CircularContainer(
                            backGroundColor:
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
                            backGroundColor:
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
                            backGroundColor: MyThemeData.darkBlue.primaryColor),
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
                            backGroundColor:
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
