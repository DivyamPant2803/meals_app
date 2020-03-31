import 'package:flutter/material.dart';
import 'package:mealsapp/dummy_data.dart';
import 'package:mealsapp/screens/filters_screen.dart';
import 'package:mealsapp/screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_sreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree)
          return false;
        if(_filters['lactose'] && !meal.isLactoseFree)
          return false;
        if(_filters['vegan'] && !meal.isVegan)
          return false;
        if(_filters['vegetarian'] && !meal.isVegetarian)
          return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);  // indexWhere returns the index if condition is true, else returns -1
    if(existingIndex>=0){
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((meal) => meal.id == id);    // It returns true if any of the meal satisfies the condition
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food 4 U',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        backgroundColor: Colors.black54,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        )
      ),
      //home: CategoriesScreen(),
        initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (cts) => FiltersScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings){   // Yeh tb chalta hai jb app ko route ke ander koi item na mile, like agar page exist nhi krta toh yeh screen dikha de
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
