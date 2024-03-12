import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_aggregator/News_Api_Inegration/api_integration.dart' as NewsApi;
import 'package:news_aggregator/repository/news_repos.dart';
import 'package:news_aggregator/Trending_news_Page/trending_news_page.dart';
import 'package:news_aggregator/bottom_Screen/bottom_screen.dart';
import 'package:news_aggregator/moor_db/db_save_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<NewsApi.Article>?> sportsNews;
  late Future<List<NewsApi.Article>?> businessNews;
  late Future<List<NewsApi.Article>?> politicNews;
  late Future<List<NewsApi.Article>?> hotNews;
  late Future<List<NewsApi.Article>?> trendingNews;
  var selectedIndex = 0;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    sportsNews = Api().getSportsNews();
    businessNews = Api().getBusinessNews();
    hotNews = Api().getHotNews();
    politicNews = Api().getPoliticalNews();
    trendingNews = Api().getTrendingNews();
    _databaseHelper = DatabaseHelper();
  }

  Future<void> _saveArticle(NewsApi.Article article) async {
    await _databaseHelper.insertArticle({
      'title': article.title,
      'description': article.description,
      'author': article.author,
      'imageUrl': article.urlToImage,
      'content': article.content,
      'publishedAt': article.publishedAt.toString(),
    });
    _loadArticles();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Article saved successfully'),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> _loadArticles() async {
    setState(() {});
  }

  Widget buildTabView(Future<List<NewsApi.Article>?> future) {
    return FutureBuilder<List<NewsApi.Article>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else if (snapshot.hasData) {
          List<NewsApi.Article>? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              final NewsApi.Article article = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Trending_Page(
                        title: article.title,
                        imageUrl: article.urlToImage ?? '',
                        description: article.description ?? '',
                        author: article.author ?? '',
                        content: article.content ?? '',
                        publishedAt: article.publishedAt,
                      ),
                    ),
                  );
                },
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 0.5,
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(article.urlToImage ?? ''),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.author ?? '',
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          article.title.length > 60
                              ? '${article.title.substring(0, 60)}...'
                              : article.title,
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    subtitle: Text(
                      'Published at ${article.publishedAt.toString()}',
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.grey.shade700),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () => _saveArticle(article),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 8.0,
            ),
            Icon(
              Icons.notifications,
              color: Colors.black,
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/news.jpeg',
            fit: BoxFit.cover,
            height: 48,
            filterQuality: FilterQuality.high,
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FutureBuilder<List<NewsApi.Article>?>(
                future: trendingNews,
                builder: (context, snapshot) {
                  try {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading trending news'));
                    } else if (snapshot.hasData) {
                      List<NewsApi.Article>? data = snapshot.data;
                      return Container(
                        height: 280.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            final NewsApi.Article article = data[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => Trending_Page(
                                          title: article.title,
                                          imageUrl:
                                          article.urlToImage ?? '',
                                          author: article.author ?? '',
                                          content: article.content ?? '',
                                          publishedAt:
                                          article.publishedAt,
                                          description:
                                          article.description ?? '',
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                width: 310,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image:
                                    NetworkImage(article.urlToImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  } catch (error) {
                    return Center(
                      child: Text('$error'),
                    );
                  }
                }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                indicator: BoxDecoration(

                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xFF4169E1)
                ),
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Sports',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Business',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Politics',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Technology',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                buildTabView(sportsNews),
                buildTabView(businessNews),
                buildTabView(politicNews),
                buildTabView(hotNews),
              ],
            ),
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.save_sharp,
                color: Colors.black,
              ),
              label: 'Saved',
            ),
          ],
          onTap: (index) {
            setState(() {
              if (index == 0) {

              } else if (index == 1) {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BottomPage(databaseHelper: _databaseHelper)),
                );
              }
            });
          },
        ),
      ),
    );
  }
}