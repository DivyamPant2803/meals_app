import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {    // Yeh method sbse pehele chalta hai, even before build method
    /*if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = DUMMY_MEALS.where((meal){   // categoryMeals is a list which will contain all those meals whose id matches with the  categoryId
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }*/
    super.initState();
  }

  @override
  void didChangeDependencies() {  // Yeh method bhi buiild method se pehele chalta hai, lekin humne initState ke ander code isliye nhi likha kyunki code mei context ka use ho rha hai, aur jis time initState chalta hai, tb tk context nhi bana hota hai
    if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal){   // categoryMeals is a list which will contain all those meals whose id matches with the  categoryId
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);    // Yeh anonymous functions saare meals ke liye chalega, aur jis meal ki id mealId se match karegi use list se remove krr dega
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(itemBuilder: (ctx, index){
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          affordability: displayedMeals[index].affordability,
          complexity: displayedMeals[index].complexity,
        );
      },itemCount: displayedMeals.length,),
      );
  }
}
