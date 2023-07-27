import 'package:flutter/material.dart';
import '../../../../model/category_dm.dart';


class Category extends StatelessWidget {
  CategoryDM categoryDM;
  Category(this.categoryDM);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
          bottomRight: categoryDM.isLeftSided ? Radius.zero : Radius.circular(12),
            bottomLeft: categoryDM.isLeftSided ? Radius.circular(12) :Radius.zero
        ),
        color: categoryDM.backgroundColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(categoryDM.imagePath),
          Spacer(),
          Text(categoryDM.title, style: TextStyle(color: Colors.white, fontSize: 18),)
        ],
      ),
    );
  }
}
