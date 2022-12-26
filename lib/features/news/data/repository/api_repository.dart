import 'dart:convert';

import 'package:design_project/features/news/data/service/api_service.dart';
import 'package:design_project/features/news/domain/models/articles_model.dart';
import 'package:design_project/features/news/domain/models/news_model.dart';

class ApiRepository {
  Future<List<Articles>?> getNews() async {
    try {
      final body = await ApiService.create().getNews();
      final news = News.fromJson(
        json.decode(body.bodyString) as Map<String, dynamic>,
      );
      return news.articles;
    } catch (e) {
      rethrow;
    }
  }
}
