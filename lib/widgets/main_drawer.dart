

import 'package:flutter/material.dart';
import 'package:mealsapp/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler){
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text('Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
              ),
            ),
            buildListTile(
              'Meals',
              Icons.restaurant,
                (){
                  Navigator.of(context).pushReplacementNamed('/');    // It will replace the previous page with the new one, rather than pushing it on the top of the stack
                }
            ),
            buildListTile(
              'Filter',
              Icons.settings,
                (){
                  Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
                }
            ),
          ],
        ),
      ),
    );
  }
}
