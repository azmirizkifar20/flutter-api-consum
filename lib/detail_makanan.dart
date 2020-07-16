import 'package:flutter/material.dart';
import './makanan.dart';

class DetailMakanan extends StatelessWidget {
  final Makanan makananDaerah;
  DetailMakanan({this.makananDaerah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makananDaerah.makanan)),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // hero animation
            HeroAnimation(makananDaerah.makanan, makananDaerah.gambar),

            // nama makanan
            Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            textComponent('Nama Makanan : ${makananDaerah.makanan}'),

            // asal daerah
            Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
            textComponent('Asal Daerah : ${makananDaerah.daerah}'),

            // deskripsi
            Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
            textComponent('Deskripsi :'),
            Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            textComponent(makananDaerah.deskripsi),
          ],
        ),
      ),
    );
  }

  Widget textComponent(String teks) {
    return Text(
      teks,
      style: TextStyle(fontSize: 16.0),
      textAlign: TextAlign.justify,
    );
  }
}

class HeroAnimation extends StatelessWidget {
  final String tag, image;
  HeroAnimation(this.tag, this.image);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(image, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
