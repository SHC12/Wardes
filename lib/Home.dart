import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/buat_data.dart';
import 'package:wardes/detail_data.dart';
import 'package:wardes/login_page.dart';
import 'package:wardes/post_data.dart';
import 'package:http/http.dart' as http;

void main() => runApp(HomeScreen());
/*
class HomeScreen extends StatelessWidget {
   SharedPreferences pref;
  String id_groups, id_instansi, id_user;
    
  Future getDataPengguna() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id_user = prefs.getString('id_user');
    
  }

  


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
}*/

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences pref;
  String id_user;

  dataAkun() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      id_user = pref.getString('id_user') ?? '0';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAkun();
  }

  Future<List<ModelData>> _getData() async {
    String URL =
        "http://wardes.pasamanbaratkab.go.id/api_android/get_data.php?id_user=";
    String URL_LENGKAP;

    URL_LENGKAP = URL + id_user;

    var data = await http.get(URL_LENGKAP);

    var jsonData = json.decode(data.body);

    List<ModelData> data_masuk = [];

    for (var u in jsonData) {
      ModelData modelData = ModelData(
          u['id_data'],
          u['judul'],
          u['what'],
          u['when'],
          u['where'],
          u['who'],
          u['why'],
          u['how'],
          u['gambar1'],
          u['gambar2'],
          u['gambar3'],
          u['gambar4'],
          u['tanggal'],
          u['status']
          );

      data_masuk.add(modelData);
    }

    print(data_masuk.length);

    return data_masuk;
  }

  List<ModelData> model_data_masuk;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Wartawan Tuah Basamo"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                pref.clear();
                pref.commit();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              })
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              // return Container(child: Center(child: Text("Loading...")));
              return Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blueGrey,
                  size: 50.0,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data.length >= 0) {
                    return new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          //Fluttertoast.showToast(msg: "token surat" + snapshot.data[index].token_surat);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailData(
                                    snapshot.data[index].id_data,
                                    snapshot.data[index].judul,
                                    snapshot.data[index].what,
                                    snapshot.data[index].when,
                                    snapshot.data[index].where,
                                    snapshot.data[index].who,
                                    snapshot.data[index].why,
                                    snapshot.data[index].how,
                                    snapshot.data[index].gambar1,
                                    snapshot.data[index].gambar2,
                                    snapshot.data[index].gambar3,
                                    snapshot.data[index].gambar4,
                                    snapshot.data[index].tanggal),
                              ));
                        },
                        child: new Card(
                            elevation: 10,
                            child: new Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.toptal.com/designers/subtlepatterns/patterns/memphis-mini.png"),
                                    fit: BoxFit.cover),
                              ),
                              padding: new EdgeInsets.all(10.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    snapshot.data[index].judul,
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(
                                        bottom: 20.0, top: 10.0),
                                    child: Text(
                                      snapshot.data[index].tanggal,
                                      style: new TextStyle(fontSize: 10.0),
                                    ),
                                  ),
                                  new Text(
                                    snapshot.data[index].status,
                                    style:
                                        snapshot.data[index].status ==
                                                'Sudah Dipublish'
                                            ? new TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.green)
                                            : new TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.blue),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.all(50.0),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Card(
                            elevation: 10,
                            child: Stack(
                              children: <Widget>[
                                Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(4)
                                        //image: DecorationImage(image: AssetImage("assets/pattern.jpg"))

                                        ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Error",
                                    style: TextStyle(
                                        color: Color(0xFFF56D5D), fontSize: 25),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  /*  return ListTile(
                      title: Text(snapshot.data[index].nama_pengirim, style: new TextStyle(color: Colors.blue),),
                      subtitle: Text(snapshot.data[index].perihal_surat),
                      onTap: (){
                      
                      },
                    );*/
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        
        children: [
          SpeedDialChild(
              child: Icon(Icons.add_comment),
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

class ModelData {
  String id_data;
  String judul;
  String what;
  String when;
  String where;
  String who;
  String why;
  String how;
  String gambar1;
  String gambar2;
  String gambar3;
  String gambar4;
  String tanggal;
  String status;

  ModelData(
      this.id_data,
      this.judul,
      this.what,
      this.when,
      this.where,
      this.who,
      this.why,
      this.how,
      this.gambar1,
      this.gambar2,
      this.gambar3,
      this.gambar4,
      this.tanggal,
      this.status);
}
