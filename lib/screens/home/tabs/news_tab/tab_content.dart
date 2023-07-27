import 'package:flutter/material.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/model/articles_response.dart';
import 'package:news_c8_online/model/sources_response.dart';

class TabContent extends StatelessWidget {
  SourceDM source;
  TabContent(this.source);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticlesResponse>(
        future: ApiManager.getArticles(source.id!),
        builder: (context, snapshot){
           if(snapshot.hasError){
             print(snapshot.error.toString());
             print(snapshot.stackTrace);
             return Text(snapshot.error.toString());
           }
           else if(snapshot.hasData){
             return ListView.builder(
                 itemCount: snapshot.data!.articles!.length,
                 itemBuilder: (context, index){
                   return buildNewsWidget(snapshot.data!.articles![index], context);
                 });
           }else {
             return const Center(child: CircularProgressIndicator());
           }
        }
    );
  }
  Widget buildNewsWidget(ArticleDM articleDM, BuildContext context){
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(),
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                      height: MediaQuery.of(context).size.height * .3,
                      fit: BoxFit.fill,
                      articleDM.urlToImage??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz0z8WX9wlhr0JtM7Qq0rIuBnrN04_ies7uw&usqp=CAU")),
            ],
          ),
          SizedBox(height: 8,),
          Text(articleDM.author??"", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.start,),
          SizedBox(height: 8,),
          Text(articleDM.title??"", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
          SizedBox(height: 8,),
          Text(articleDM.publishedAt??"", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.end,)
        ],
      ),
    );
  }
}
