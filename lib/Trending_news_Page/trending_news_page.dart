import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Trending_Page extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final String content;
  DateTime publishedAt;

  Trending_Page({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.author,
    required this.content,
    required this.publishedAt,
  }) : super(key: key);

  @override
  State<Trending_Page> createState() => _Trending_PageState();
}

class _Trending_PageState extends State<Trending_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar.large(
        backgroundColor: Colors.white,
        leading: Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.only(top: 8, left: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: IconButton(
            color: Colors.grey[200],
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        expandedHeight: 350,
        pinned: true,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          background: ClipRRect(
              child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
          )),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.author,
                      style: GoogleFonts.playfair(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.title,
                        style: GoogleFonts.merriweather(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description: ',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.description,
                      style: GoogleFonts.roboto(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Content: ',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.content,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Published: ',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Published at ${widget.publishedAt.toString()}',
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
                    )
                  ])))
    ]));
  }
}
