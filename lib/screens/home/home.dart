import 'package:flutter/material.dart';
import 'package:news_c8_online/model/category_dm.dart';
import 'package:news_c8_online/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_c8_online/screens/home/tabs/news_tab/news_tab.dart';
import 'package:news_c8_online/screens/home/tabs/settings/settings.dart';


class Home extends StatefulWidget {
  static String routeName = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM? selectedCategory;
  late Widget currentTab ;

  @override
  void initState() {
    super.initState();
    currentTab = CategoriesTab(setSelectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(currentTab is NewsTab || currentTab is SettingsTab){
          currentTab = CategoriesTab(setSelectedCategory);
          setState(() {});
          return Future.value(false);
        }else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text("News"),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        body: currentTab,

        drawer: buildDrawer(),

      ),
    );
  }

  Widget buildDrawer(){
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .2,
            color: Colors.blue,
            child: Center(child: Text("News App", style: TextStyle(color: Colors.white, fontSize: 28),)),
          ),
          SizedBox(height: 8,),
          InkWell(
              onTap: (){
                currentTab = SettingsTab();
                Navigator.pop(context);
                setState(() {});
              },
              child: buildDrawerRow(Icons.settings, "Settings")
          ),
          SizedBox(height: 8,),
          InkWell(
            onTap: (){
              currentTab = CategoriesTab(setSelectedCategory);
              setState(() {});
              Navigator.pop(context);
            },
              child: buildDrawerRow(Icons.menu, "Categories"))
        ],
      ),
    );
  }

  Widget buildDrawerRow(IconData iconData, String title){
    return Row(
      children: [
        SizedBox(width: 8,),
        Icon(iconData, color: Colors.black, size: 32,),
        SizedBox(width: 8,),
        Text(title, style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),)
      ],
    );
  }

  void setSelectedCategory( CategoryDM newCategory){
    selectedCategory = newCategory;
    currentTab = NewsTab(selectedCategory!);
    setState(() {});
  }
}
