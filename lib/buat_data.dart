import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardes/ImageUploadModel.dart';

void main() => runApp(BuatData());

class BuatData extends StatefulWidget {
  @override
  _BuatDataState createState() => _BuatDataState();
}

class _BuatDataState extends State<BuatData> {
  ProgressDialog pr;
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  File _image;
  File _image2;
  File _image3;
  File _image4;

  String nama;
  String instansi;
  String id_user;

  TextEditingController tf_what = new TextEditingController();
  TextEditingController tf_when = new TextEditingController();
  TextEditingController tf_who = new TextEditingController();
  TextEditingController tf_where = new TextEditingController();
  TextEditingController tf_why = new TextEditingController();
  TextEditingController tf_how = new TextEditingController();
  TextEditingController tf_judul = new TextEditingController();

  Future getDataPengguna() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id_user = prefs.getString('id_user');
    nama = prefs.getString('nama_lengkap');
    instansi = prefs.getString('daerah');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPengguna();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: 'Mohon Tunggu...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Buat Data Baru"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Container(
            padding: new EdgeInsets.all(12.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: tf_judul,
                  decoration: new InputDecoration(
                      hintText: "Masukkan judul atas informasi yang diberikan",
                      labelText: "Judul",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: tf_what,
                  decoration: new InputDecoration(
                      hintText: "Topik atau tema yang akan dijadikan tulisan",
                      labelText: "What (apa)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  controller: tf_when,
                  minLines: 1,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      hintText: "Periode waktu dari what diatas",
                      labelText: "When (kapan)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  controller: tf_where,
                  minLines: 1,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      hintText:
                          "Dimana kejadian yang terhubung dengan what diatas",
                      labelText: "Where (dimana)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  controller: tf_who,
                 minLines: 1,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      hintText: "Siapa berkaitan dengan orang atau lembaga",
                      labelText: "Who (siapa)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  controller: tf_why,
                  minLines: 1,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      hintText: "Bagian yang menjelaskan tema tulisan",
                      labelText: "Why (mengapa)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  controller: tf_how,
                  minLines: 1,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      hintText: "Menjelaskan tema yang dipilih",
                      labelText: "How (bagaimana)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                //buildGridView(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: new Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: _image == null
                                      ? NetworkImage(
                                          'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                      : FileImage(_image),
                                  radius: 50.0,
                                ),
                                InkWell(
                                  onTap: _onAlertPress,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          color: Colors.black),
                                      margin:
                                          EdgeInsets.only(left: 70, top: 70),
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                            Text('Tambahkan Gambar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: _image2 == null
                                      ? NetworkImage(
                                          'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                      : FileImage(_image2),
                                  radius: 50.0,
                                ),
                                InkWell(
                                  onTap: _onAlertPress2,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          color: Colors.black),
                                      margin:
                                          EdgeInsets.only(left: 70, top: 70),
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                            Text('Tambahkan Gambar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: _image3 == null
                                      ? NetworkImage(
                                          'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                      : FileImage(_image3),
                                  radius: 50.0,
                                ),
                                InkWell(
                                  onTap: _onAlertPress3,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          color: Colors.black),
                                      margin:
                                          EdgeInsets.only(left: 70, top: 70),
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                            Text('Tambahkan Gambar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: _image4 == null
                                      ? NetworkImage(
                                          'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                      : FileImage(_image4),
                                  radius: 50.0,
                                ),
                                InkWell(
                                  onTap: _onAlertPress4,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          color: Colors.black),
                                      margin:
                                          EdgeInsets.only(left: 70, top: 70),
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                            Text('Tambahkan Gambar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    String how = tf_how.text;
                    String why = tf_why.text;
                    String who = tf_who.text;
                    String where = tf_where.text;
                    String when = tf_when.text;
                    String what = tf_what.text;

                    if (how != '' &&
                        why != '' &&
                        who != '' &&
                        where != '' &&
                        when != '' &&
                        what != '' &&
                        _image != null) {
                      _startUploading();
                    } else {
                      messageAllertGagal(
                          'Data tidak boleh ada yang kosong', 'Gagal');
                    }
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Kirim Data',
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
//      resizeToAvoidBottomPadding: false,
    );
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Galeri'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              
            ],
          );
        });
  }

  void _onAlertPress2() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Galeri'),
                  ],
                ),
                onPressed: getGalleryImage2,
              ),
              
            ],
          );
        });
  }

  void _onAlertPress3() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Galeri'),
                  ],
                ),
                onPressed: getGalleryImage3,
              ),
              
            ],
          );
        });
  }

  void _onAlertPress4() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Galeri'),
                  ],
                ),
                onPressed: getGalleryImage4,
              ),
              
            ],
          );
        });
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,  imageQuality: 50);

    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  Future getCameraImage2() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image2 = image2;
      Navigator.pop(context);
    });
  }

  Future getGalleryImage2() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.gallery,  imageQuality: 50);

    setState(() {
      _image2 = image2;
      Navigator.pop(context);
    });
  }

  Future getCameraImage3() async {
    var image3 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image3 = image3;
      Navigator.pop(context);
    });
  }

  Future getGalleryImage3() async {
    var image3 = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image3 = image3;
      Navigator.pop(context);
    });
  }

  Future getCameraImage4() async {
    var image4 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image4 = image4;
      Navigator.pop(context);
    });
  }

  Future getGalleryImage4() async {
    var image4 = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image4 = image4;
      Navigator.pop(context);
    });
  }

  void getDataConroller() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 200.0,
        child: new Column(
          children: <Widget>[
            new Text("What : ${tf_what.text}"),
            new Text("When : ${tf_when.text}"),
            new Text("Where : ${tf_where.text}"),
            new Text("Who : ${tf_who.text}"),
            new Text("Why : ${tf_why.text}"),
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  Uri apiUrl = Uri.parse(
      'http://wardes.pasamanbaratkab.go.id/api_android/post_data.php');

  Future<Map<String, dynamic>> _uploadImage(
      File image, File image2, File image3, File image4) async {
    setState(() {
      pr.show();
    });

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    final mimeTypeData2 =
        lookupMimeType(image2.path, headerBytes: [0xFF, 0xD8]).split('/');

    final mimeTypeData3 =
        lookupMimeType(image3.path, headerBytes: [0xFF, 0xD8]).split('/');

    final mimeTypeData4 =
        lookupMimeType(image4.path, headerBytes: [0xFF, 0xD8]).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath('gbr1', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    final file2 = await http.MultipartFile.fromPath('gbr2', image2.path,
        contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

    final file3 = await http.MultipartFile.fromPath('gbr3', image3.path,
        contentType: MediaType(mimeTypeData3[0], mimeTypeData3[1]));

    final file4 = await http.MultipartFile.fromPath('gbr4', image4.path,
        contentType: MediaType(mimeTypeData4[0], mimeTypeData4[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(file2);
    imageUploadRequest.files.add(file3);
    imageUploadRequest.files.add(file4);
    imageUploadRequest.fields['id_user'] = id_user;
    imageUploadRequest.fields['nama'] = nama;
    imageUploadRequest.fields['instansi'] = instansi;
    imageUploadRequest.fields['judul'] = tf_judul.text;
    imageUploadRequest.fields['what'] = tf_what.text;
    imageUploadRequest.fields['when'] = tf_when.text;
    imageUploadRequest.fields['where'] = tf_where.text;
    imageUploadRequest.fields['who'] = tf_who.text;
    imageUploadRequest.fields['why'] = tf_why.text;
    imageUploadRequest.fields['how'] = tf_how.text;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> _uploadImage1(File image) async {
    setState(() {
      pr.show();
    });

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath('gbr1', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);

    imageUploadRequest.fields['id_user'] = id_user;
    imageUploadRequest.fields['nama'] = nama;
    imageUploadRequest.fields['instansi'] = instansi;
    imageUploadRequest.fields['judul'] = tf_judul.text;
    imageUploadRequest.fields['what'] = tf_what.text;
    imageUploadRequest.fields['when'] = tf_when.text;
    imageUploadRequest.fields['where'] = tf_where.text;
    imageUploadRequest.fields['who'] = tf_who.text;
    imageUploadRequest.fields['why'] = tf_why.text;
    imageUploadRequest.fields['how'] = tf_how.text;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> _uploadImage2(File image, File image2) async {
    setState(() {
      pr.show();
    });

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    final mimeTypeData2 =
        lookupMimeType(image2.path, headerBytes: [0xFF, 0xD8]).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath('gbr1', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    final file2 = await http.MultipartFile.fromPath('gbr2', image2.path,
        contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(file2);

    imageUploadRequest.fields['id_user'] = id_user;
    imageUploadRequest.fields['nama'] = nama;
    imageUploadRequest.fields['instansi'] = instansi;
    imageUploadRequest.fields['judul'] = tf_judul.text;
    imageUploadRequest.fields['what'] = tf_what.text;
    imageUploadRequest.fields['when'] = tf_when.text;
    imageUploadRequest.fields['where'] = tf_where.text;
    imageUploadRequest.fields['who'] = tf_who.text;
    imageUploadRequest.fields['why'] = tf_why.text;
    imageUploadRequest.fields['how'] = tf_how.text;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> _uploadImage3(
      File image, File image2, File image3) async {
    setState(() {
      pr.show();
    });

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeData2 =
        lookupMimeType(image2.path, headerBytes: [0xFF, 0xD8]).split('/');

    final mimeTypeData3 =
        lookupMimeType(image3.path, headerBytes: [0xFF, 0xD8]).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath('gbr1', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    final file2 = await http.MultipartFile.fromPath('gbr2', image2.path,
        contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));
    final file3 = await http.MultipartFile.fromPath('gbr3', image3.path,
        contentType: MediaType(mimeTypeData3[0], mimeTypeData3[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(file2);
    imageUploadRequest.files.add(file3);
    imageUploadRequest.fields['id_user'] = id_user;
    imageUploadRequest.fields['nama'] = nama;
    imageUploadRequest.fields['instansi'] = instansi;
    imageUploadRequest.fields['judul'] = tf_judul.text;
    imageUploadRequest.fields['what'] = tf_what.text;
    imageUploadRequest.fields['when'] = tf_when.text;
    imageUploadRequest.fields['where'] = tf_where.text;
    imageUploadRequest.fields['who'] = tf_who.text;
    imageUploadRequest.fields['why'] = tf_why.text;
    imageUploadRequest.fields['how'] = tf_how.text;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _resetState() {
    setState(() {
      pr.hide();
    });
  }

  void _startUploading() async {
    String how = tf_how.text;
    String why = tf_why.text;
    String who = tf_who.text;
    String where = tf_where.text;
    String when = tf_when.text;
    String what = tf_what.text;

    /* if (how != '' &&
        why != '' &&
        who != '' &&
        where != '' &&
        when != '' &&
        what != '' &&
        _image != null) {
      final Map<String, dynamic> response =
          await _uploadImage(_image, _image2, _image3, _image4);

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Sukses');
      }
    }  else {
      messageAllertGagal('Data tidak boleh ada yang kosong', 'Gagal');
    }*/

    if (_image2 == null && _image3 == null && _image4 == null) {
      final Map<String, dynamic> response = await _uploadImage1(_image);

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Sukses');
      }
    } else if (_image3 == null && _image4 == null) {
      final Map<String, dynamic> response =
          await _uploadImage2(_image, _image2);

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Sukses');
      }
    } else if (_image4 == null) {
      final Map<String, dynamic> response =
          await _uploadImage3(_image, _image2, _image3);

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Sukses');
      }
    } else if (_image != null &&
        _image2 != null &&
        _image3 != null &&
        _image4 != null) {
      final Map<String, dynamic> response =
          await _uploadImage(_image, _image2, _image3, _image4);

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Sukses');
      }
    } else {
      messageAllertGagal('Data tidak boleh ada yang kosong', 'Gagal');
    }
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Ok'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  messageAllertGagal(String msg, String ttl) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Oke'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
