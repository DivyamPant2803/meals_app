import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.isEmpty){
      return Container(
        color: Colors.black87,
        child: Center(
          child: Text('You have no favourites yet - start adding some',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    else{
      return Container(
        color: Colors.black87,
        child: ListView.builder(itemBuilder: (ctx, index){
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
          );
        },itemCount: favouriteMeals.length,),
      );
    }
  }
}
