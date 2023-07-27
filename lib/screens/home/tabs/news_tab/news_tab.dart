import 'package:flutter/material.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/model/api_exception.dart';
import 'package:news_c8_online/model/category_dm.dart';
import 'package:news_c8_online/model/sources_response.dart';
import 'package:news_c8_online/screens/home/tabs/news_tab/tab_content.dart';

class NewsTab extends StatefulWidget {
  CategoryDM categoryDM;
  NewsTab(this.categoryDM);
  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;
  String name ="";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<SourcesResponse>(
        future: ApiManager.getSources(widget.categoryDM.id),
        builder: (context, snapshot){
          if(snapshot.hasError){
            if(snapshot.error is ApiException){
              var error = snapshot.error as ApiException;
              return Center(child: Text(error.message,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
            }
             return Center(child: Text(snapshot.error.toString(),
               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
          }
          else if(snapshot.hasData){
            return  DefaultTabController(
              length: snapshot.data!.sources!.length,
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  TabBar(tabs: snapshot.data!.sources!.map((sourceDM) {
                    return buildTabWidget(sourceDM.name ?? "unkown",
                        currentTabIndex == snapshot.data!.sources!.indexOf(sourceDM));
                  }).toList(),
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    onTap: (index){
                      currentTabIndex = index;
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: TabBarView(children: snapshot.data!.sources!.map((sourceDM) {
                      return TabContent(sourceDM);
                    }).toList()),
                  )
                ],
              ),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildTabWidget(String sourceName, bool isSelected){
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ?Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 2)
      ),
      child: Text(sourceName, style: TextStyle(color: isSelected ? Colors.white : Colors.blue),),
    );
  }
}
