import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem(this.id, this.title,this.color);

  void selectCategory(BuildContext context){
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName,
      arguments: {
      'id': id,
      'title': title,
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(   // Similar to GestureDectector but with an additional ripple effect
      onTap: () =>  selectCategory(context),
      splashColor: Theme.of(context).primaryColor,    // Color of ripple
      borderRadius: BorderRadius.circular(15),        // radius of ripple
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
            title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7), // transparency in the color
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
