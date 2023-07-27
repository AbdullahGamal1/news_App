import 'package:flutter/material.dart';

import '../../../../model/category_dm.dart';
import 'category.dart';

class CategoriesTab extends StatelessWidget {
  Function(CategoryDM) setSelectedCategory;
  CategoriesTab(this.setSelectedCategory);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Pick your category of intereset", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
                itemCount: CategoryDM.categories.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      setSelectedCategory(CategoryDM.categories[index]);
                    },
                      child: Category(CategoryDM.categories[index]));
                },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12
              ),
            ),
          ),
        )
      ],
    ) ;
  }
}
