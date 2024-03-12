import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_aggregator/moor_db/db_save_page.dart';

class BottomPage extends StatefulWidget {
  final DatabaseHelper? databaseHelper;

  const BottomPage({this.databaseHelper});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  late DatabaseHelper _databaseHelper;

  @override
  Widget build(BuildContext context) {
    var databaseHelper = widget.databaseHelper;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Saved Articles",
          style: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: databaseHelper?.getAllArticles() ?? Future.value([]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading saved articles'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                            height:500,
                            width: 500,
                            child: AlertDialog(
                              title: Text(
                                article['title'] ?? '',
                                style: GoogleFonts.roboto(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    article['imageUrl'] ?? '',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text('Description:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(article['description'] ??
                                      'no description'),
                                  const SizedBox(height: 8),
                                  Text('Content:',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(article['content'] ?? 'No Content'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('close'),
                                )
                              ],
                            ));
                      },
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text(article['author'] ?? 'Unknown Author'),
                      leading: Image.network(
                        article['imageUrl'] ?? '',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      // Add more details as needed
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No saved articles available'));
          }
        },
      ),
    );
  }
}
