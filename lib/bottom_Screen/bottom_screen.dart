
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading saved articles'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                print('article is ${article['imageUrl'] }');
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            " Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction){
                    if(direction==DismissDirection.endToStart){
                      setState(() {
                        databaseHelper?.delete(article['title'] );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Article Removed successfully',style: TextStyle(color: Colors.white),),
                          duration: Duration(seconds: 2),
                        ));
                      });
                    }
                  },
                  child: GestureDetector(
                    // onDoubleTap: (){
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return SizedBox(
                    //           height:500,
                    //           width: 500,
                    //           child: AlertDialog(
                    //             title: Text(
                    //               article['title'] ?? '',
                    //               style: GoogleFonts.roboto(
                    //                   fontSize: 20, fontWeight: FontWeight.bold),
                    //             ),
                    //             actions: [
                    //               TextButton(
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     databaseHelper?.delete(article['title'] );
                    //                     Navigator.pop(context);
                    //                   });
                    //
                    //                 },
                    //                 child: const Text('delete'),
                    //               ),
                    //               TextButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text('close'),
                    //               )
                    //             ],
                    //           ));
                    //     },
                    //   );
                    // },
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
                                    article['imageUrl']==null?SizedBox(): Image.network(
                                      article['imageUrl'] ?? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALwAAACUCAMAAAAeaLPCAAAAY1BMVEX///8AAAD8/PwEBATs7Oz5+fmurq61tbXz8/OpqalISEjo6Oj29vbd3d3k5OR+fn7Hx8cODg7T09OTk5ONjY29vb1SUlKZmZmioqJpaWkYGBhdXV0gICBxcXEsLCw3NzdBQUGSQhSoAAAFGUlEQVR4nO2c65KqOhCFQ7iK3ARBEWF8/6c8CXq2Oq5IdNdJOnX49o/Z5WjVsqfp9A0YW1lZWVlZWXEAfvsRBnldtXHcVnmR8Mdf0Sao20M3+d4fTmm5qYrQtq5lgrYZzh5AfIHctjgVnEuv2O7TE1J+5TJW8ztta31BSMrqTi38xjlOKKoPq1Gq8z3/vfw0zmxLfUaYshjf+Msd+c3G+vYZAnD5bzN5Sya/c2o4FfFCRtEL6draxRuHnIp4dr1Q9cWLd6aVbdHsGiHbSVf2A+eWRNQ5fCFdEtn3nPD4gcPcEa6zi22Kn//s0Zd2F0yV1ZjDWfW9dmH+rT3pgvwrn7lJ9700sag96b7XPtNYdJu9ln3fcK6taW93f6Vculxny3ECldPMr3bl/rDZHJtyrk2Ub9xYkc5Vp9Ns7uZe9gV19KM2/tlOdRgqDbrbb+8XovxfEqkzCDumb1Ryhqda9Zr9JqPK/a14fZBiMbs9VBMeYVk+Z2jmiRWmPIbozJf1isL0jXntWYkdPsL5ikydFeo780lCgS/B8t1neqze/EGFMjLfG5J3eWKBQ2ZsTrWEKzKD08LFd/z8r/WfAGPNkowt7EpdDMh9IvzOe3EmZzq1LJCIdPFjFYxQpltoLRKxXFJnMEYVRiTfgTFbo4UNnd506xtllFO2XE+XFMSjrGyAicEjijTavnjfKzWiBnQ30/kBsqBOhgWPKdPRBonQEQ8Dvek4jxply27DYW72Y0LwIygvGzTKUZSa9aa7fjkQMS0XdAWa/RxMi0+Q7y6HPBhsauPtVtQ5aJZUZAPQfjGdHeBzflr6UIWK8NJ856Ytm8PhKIiieKYVLMgIYd1ruJD6jhA387vAtjAtkh0y/MG2LC1COd5/Vf+2ZKeBSDhxCbinr52zoARm970poC9eDvh9NGo42hamQQ7LP99Gq+9j4OEk58g2OsQfUnkwznjeSN/h4x3ULgy/JS6eswieTZLItrhF5GIFHmnuaZtdGF6tPTWfCn8CV/uMeLGi7fCcxeopuPHi71Nq9Z5lyUlr5yxXT76HgLThRS6GKtarw/u0L1ZRbffKTaJzQdnskkZKf82CxQX8Y2/LRgdh1wov4wjtE23t8mJVrCZ43o7OKq4CWbBih7/kJFZZ3xGr7J4S9xmJaruGfpyRczOsvuO3m0sIUyu2snqbS6CahKjNIV5JXejs1TjE7xLS+cwVPr5a3Z+3V8lLx0sVvhv9JdWtDL3GcN8+2QSbkgX5g1WdkTnhNFwOuV/j5I8DEV6QwAVE+v0lNufCF6A9pd7Yu1GhITf55tiN1+0z386y8ze8TugdSWokaBNnsC1KFyTe/MLtl2xkd+MZb29blB6cZcEzW4EbJxRzIGNXg3q/Dn+dlZX/C2ESBDJEune58upY9sMwNrEDmxGPyEqw/7dldkoPmTPWl53I4LlvM7XuiH8eK1xvjrWtShM8ErFzz+vnJK/zS1/euUa+aSNBN5O4sY7FWAa027tP/ROEa+BbFz3v4sBTzPBNXBLyc7R5VUK9oUIduIM4M9qWtkysfICGA90PtfjOtrRlWqXb9LalLaMawDrRd0qUux70W62cvU4xb7jQd6rd9RoGHykgjq0T+QN2Bt7958L5ymRuFv1W77ux7cHmXuXxt3RX5phzwfR4zErtvStDnblRkD8+8rSLFm/KpwRnYbW/Rp3zGFFfvP2N8B0ebPO6LgJiT8LVgM7jY1dWVlZWVlZWVozwD+oJMddoswpxAAAAAElFTkSuQmCC',
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
                        leading:  article['imageUrl']==null?Text("N/A",textAlign: TextAlign.center,): Image.network(
                          article['imageUrl'] ?? '',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        // Add more details as needed
                      ),
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
