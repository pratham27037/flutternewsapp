import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/model/article_model.dart';
import 'package:flutternews/model/category_model.dart';
import 'package:flutternews/views/article_views.dart';
import 'package:flutternews/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews () async{
    News newsClass = News();
    await newsClass.getNews();
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
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 70.0,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      }
                  ),
                ),
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
      ),
      );

  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({this.imageUrl,this.categoryName});
  final String imageUrl,categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryNews(
          category: categoryName.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl: imageUrl,width: 120.0,height: 60.0,fit: BoxFit.cover,)

            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ],
        ),
      ),
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
