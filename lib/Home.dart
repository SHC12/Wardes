import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wardes/buat_data.dart';
import 'package:wardes/post_data.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Daftar Data"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
          
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.ac_unit),
                label: "Buat Data Baru",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BuatData();
                  }));
                }),
          ],
        ),
      
    );
  }
}
