import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_json/makanan.dart';
import 'dart:async';
import 'dart:convert';

import './detail_makanan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makanan Daerah',
      home: MyHomePage(
        alt: 'media',
        token: '1eab03cc-867b-4a8d-bc59-1355ddb7822a',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String alt, token;
  MyHomePage({this.alt, this.token});

  @override
  _MyHomePageState createState() => _MyHomePageState(alt: alt, token: token);
}

class _MyHomePageState extends State<MyHomePage> {
  List dataJSON;
  final String alt, token;
  _MyHomePageState({this.alt, this.token});

  // ignore: missing_return
  Future<String> ambilData() async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/rizkifar-project.appspot.com/o/makanan-dayah.json?alt=$alt&token=$token';
    http.Response hasil = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept': 'application/json'},
    );

    this.setState(() {
      dataJSON = json.decode(hasil.body);
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    this.ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Makanan Daerah Indonesia')),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMakanan(
                    makananDaerah: Makanan(
                      dataJSON[i]['id'],
                      dataJSON[i]['daerah'],
                      dataJSON[i]['makanan'],
                      dataJSON[i]['gambar'],
                      dataJSON[i]['deskripsi'],
                    ),
                  ),
                ),
              ),
              child: CardView(
                photo: dataJSON[i]['gambar'],
                judul: dataJSON[i]['makanan'],
                deskripsi: dataJSON[i]['deskripsi'],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final String photo, judul, deskripsi;
  const CardView({this.photo, this.judul, this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            // hero animation (image)
            HeroAnimation(tag: judul, image: photo),

            // padding
            Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),

            // flex column
            FlexColumn(judul: judul, deskripsi: deskripsi)
          ],
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  final String tag, image;
  HeroAnimation({this.tag, this.image});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(image, width: 160.0),
          ),
        ),
      ),
    );
  }
}

class FlexColumn extends StatelessWidget {
  final String judul, deskripsi;
  FlexColumn({this.judul, this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            judul,
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(deskripsi, maxLines: 4)
        ],
      ),
    );
  }
}
