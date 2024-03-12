import 'package:news_aggregator/News_Api_Inegration/api_integration.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


class Api {
  static const _businessUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';
  static const _sportsUrl =
      'https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';
  static const _technologyUrl =
      'https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';
  static const _hotNews =
      'https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';
  static const _politicalUrl =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';
  static const _trendingUl =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=b9d0953cb8a648a89ad4b2240a47d75b';

  Future<List<Article>?> getBusinessNews() async {
    try {
      final response = await http.get(Uri.parse(Api._businessUrl));
      if (response.statusCode == 200) {
        final decodeData = json.decode(response.body)['articles'] as List;
        print(decodeData);
        return decodeData.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(('Error during Api req ;$error'));
    }
  }

  Future<List<Article>?> getSportsNews() async {
    final response = await http.get(Uri.parse(Api._sportsUrl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['articles'] as List;
      print(decodeData);
      return decodeData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<List<Article>?> getTechnologyNews() async {
    final response = await http.get(Uri.parse(Api._technologyUrl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['articles'] as List;
      print(decodeData);
      return decodeData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Article>?> getHotNews() async {
    final response = await http.get(Uri.parse(Api._hotNews));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['articles'] as List;
      print(decodeData);
      return decodeData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Article>> getPoliticalNews() async {
    final response = await http.get(Uri.parse(Api._politicalUrl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['articles'] as List;
      print(decodeData);
      return decodeData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<List<Article>?> getTrendingNews() async {
    final response = await http.get(Uri.parse(Api._trendingUl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['articles'] as List;
      print(decodeData);
      return decodeData.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
