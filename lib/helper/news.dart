import 'dart:convert';

import 'package:flutternews/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "http://newsapi.org/v2/top-headlines?country=in&apiKey=e00825dcc66a4cb4a3b7b34ad6c43da4";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            content: element['content'],
          );
          news.add(articleModel);
        }

      });

    }
  }
}

class categoryNews {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=e00825dcc66a4cb4a3b7b34ad6c43da4";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            content: element['content'],
          );
          news.add(articleModel);
        }

      });

    }
  }
}