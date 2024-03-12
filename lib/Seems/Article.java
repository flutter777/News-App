//import 'dart:async';
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//
//class Article {
//  final String title;
//  final String description;
//  final String author;
//  final String urlToImage;
//  final String content;
//  final DateTime publishedAt;
//
//  Article({
//    required this.title,
//    required this.description,
//    required this.author,
//    required this.urlToImage,
//    required this.content,
//    required this.publishedAt,
//  });
//
//  factory Article.fromJson(Map<String, dynamic> json) {
//    return Article(
//      title: json['title'] ?? '',
//      description: json['description'] ?? '',
//      author: json['author'] ?? '',
//      urlToImage: json['urlToImage'] ?? '',
//      content: json['content'] ?? '',
//      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
//    );
//  }
//}
//
//class DatabaseHelper {
//  static Database? _database;
//
//  Future<Database> get database async {
//    if (_database != null) {
//      return _database!;
//    }
//
//    _database = await initDatabase();
//    return _database!;
//  }
//
//  Future<Database> initDatabase() async {
//    final documentsDirectory = await getDatabasesPath();
//    final path = join(documentsDirectory, 'news_database.db');
//
//    return await openDatabase(path, version: 1, onCreate: _createDatabase);
//  }
//
//  Future<void> _createDatabase(Database db, int version) async {
//    await db.execute('''
//      CREATE TABLE news_articles(
//        id INTEGER PRIMARY KEY AUTOINCREMENT,
//        title TEXT,
//        description TEXT,
//        content TEXT,
//        imageUrl TEXT,
//        author TEXT,
//        publishedAt TEXT
//      )
//    ''');
//  }
//
//  Future<List<Map<String, dynamic>>> getAllArticles() async {
//    final Database db = await database;
//    return await db.query('news_articles');
//  }
//
//  Future<int> insertArticle(Map<String, dynamic> article) async {
//    final Database db = await database;
//    return await db.insert('news_articles', article);
//  }
//
//  Future<int> updateArticle(int id, Map<String, dynamic> updatedData) async {
//    final Database db = await database;
//    return await db.update(
//      'news_articles',
//      updatedData,
//      where: 'id = ?',
//      whereArgs: [id],
//    );
//  }
//}