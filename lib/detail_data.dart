import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:wardes/ubah_data.dart';

class DetailData extends StatefulWidget {
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
  DetailData(
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
      this.tanggal);

  @override
  _DetailDataState createState() => _DetailDataState(id_data, judul, what, when,
      where, who, why, how, gambar1, gambar2, gambar3, gambar4, tanggal);
}

class _DetailDataState extends State<DetailData> {
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
  _DetailDataState(
      String this.id_data,
      String this.judul,
      String this.what,
      String this.when,
      String this.where,
      String this.who,
      String this.why,
      String this.how,
      String this.gambar1,
      String this.gambar2,
      String this.gambar3,
      String this.gambar4,
      String this.tanggal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: new Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 6,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Tanggal : ",
                            style: TextStyle(fontSize: 15),
                          ),
                          Flexible(
                              child: Text(
                            widget.tanggal,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Judul : ",
                            style: TextStyle(fontSize: 15),
                          ),
                          Flexible(
                              child: Text(
                            widget.judul,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "What (apa) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.what,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "When (kapan) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.when,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Where (dimana) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.where,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Who (siapa) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.who,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Why (siapa) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.why,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "How (bagaimana) : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Flexible(
                          child: Text(
                        widget.how,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ))
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: new Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                           backgroundImage: widget.gambar1 ==
                                      'http://wardes.pasamanbaratkab.go.id/image/'
                                  ? NetworkImage(
                                      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                  : NetworkImage(widget.gambar1),
                              radius: 50.0,
                            ),
                          ],
                        ),
                        Text('Gambar 1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: widget.gambar2 ==
                                      'http://wardes.pasamanbaratkab.go.id/image/'
                                  ? NetworkImage(
                                      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                  : NetworkImage(widget.gambar2),
                              radius: 50.0,
                            ),
                          ],
                        ),
                        Text('Gambar 2',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: widget.gambar3 ==
                                      'http://wardes.pasamanbaratkab.go.id/image/'
                                  ? NetworkImage(
                                      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                  : NetworkImage(widget.gambar3),
                              radius: 50.0,
                            ),
                          ],
                        ),
                        Text('Gambar 3',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: widget.gambar4 ==
                                      'http://wardes.pasamanbaratkab.go.id/image/'
                                  ? NetworkImage(
                                      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                  : NetworkImage(widget.gambar4),
                              radius: 50.0,
                            ),
                          ],
                        ),
                        Text('Gambar 4',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10.0)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue),
                child: FlatButton(
                  child: FittedBox(
                      child: Text(
                    'Ubah Data',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UbahData(
                              widget.id_data,
                              widget.judul,
                              widget.what,
                              widget.when,
                              widget.where,
                              widget.who,
                              widget.why,
                              widget.how,
                              widget.gambar1,
                              widget.gambar2,
                              widget.gambar3,
                              widget.gambar4,
                              widget.tanggal),
                        ));
                  },
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
