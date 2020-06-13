import 'package:flutter/material.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/model/article_model.dart';

import 'article_views.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  getCategoryNews () async{
    categoryNews newsClass = categoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text('NEWS',style: TextStyle(color: Colors.blueAccent),)
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading ? Center(
              child: Container(
                   child: CircularProgressIndicator(),
                ),
           ): SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){
                  return BlogTile(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description,url: articles[index].url,);
                },
                shrinkWrap: true,
                itemCount: articles.length,
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}

class BlogTile extends StatelessWidget {
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  final String imageUrl,title,desc,url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => ArticleView(
          blogUrl: url,
        )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl)),
            Text(title,style: TextStyle(
              fontWeight: FontWeight.w500,
              color:Colors.black87,
              fontSize: 18,
            ),),
            SizedBox(
              height: 6,
            ),
            Text(desc,style: TextStyle(
              color: Colors.black54,
            ),),
          ],
        ),
      ),
    );
  }
}