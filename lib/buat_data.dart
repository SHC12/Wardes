import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
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

  TextEditingController tf_what = new TextEditingController();
  TextEditingController tf_when = new TextEditingController();
  TextEditingController tf_who = new TextEditingController();
  TextEditingController tf_where = new TextEditingController();
  TextEditingController tf_why = new TextEditingController();
  TextEditingController tf_how = new TextEditingController();
  TextEditingController tf_judul = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: 'Please wait...',
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
                  maxLines: 2,
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
                  maxLines: 2,
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
                  maxLines: 2,
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
                  maxLines: 2,
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
                  maxLines: 2,
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
                  maxLines: 3,
                  decoration: new InputDecoration(
                      hintText: "Menjelaskan tema yang dipilih",
                      labelText: "How (bagaimana)",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                ),
                buildGridView(),
                const SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    _startUploading();
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

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2 * 2,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
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

  Future<Map<String, dynamic>> _uploadImage() async {
    setState(() {
      pr.show();
    });

    /* final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
*/
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    // Attach the file in the request
    /* final file = await http.MultipartFile.fromPath(
        'half_body_image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));*/
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    // imageUploadRequest.files.add(file);
    imageUploadRequest.fields['id_user'] = "4370";
    imageUploadRequest.fields['nama'] = "dedi";
    imageUploadRequest.fields['instansi'] = "kominfo";
    imageUploadRequest.fields['what'] = tf_what.text;
    imageUploadRequest.fields['when'] = tf_when.text;
    imageUploadRequest.fields['where'] = tf_where.text;
    imageUploadRequest.fields['who'] = tf_who.text;
    imageUploadRequest.fields['why'] = tf_why.text;
    imageUploadRequest.fields['how'] = tf_how.text;
    imageUploadRequest.fields['gambar1'] = "gbr1";
    imageUploadRequest.fields['gambar2'] = "gbr2";
    imageUploadRequest.fields['gambar3'] = "gbr3";
    imageUploadRequest.fields['gambar4'] = "gbr4";

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
    if (how != '' &&
        why != '' &&
        who != '' &&
        where != '' &&
        when != '' &&
        what != '') {
      final Map<String, dynamic> response = await _uploadImage();

      if (response == null) {
        pr.hide();
        messageAllert('Data Berhasil Dikirim', 'Success');
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
