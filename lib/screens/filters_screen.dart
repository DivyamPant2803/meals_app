import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegeterian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegeterian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, bool currentValue, String subtitle, Function updateValue){
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.white),),
      value: currentValue,
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white)),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save), onPressed: (){
          final selectedFilters = {
            'gluten': _glutenFree,
            'lactose': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegeterian,
          };
          widget.saveFilters(selectedFilters);
        }),
      ],),
      backgroundColor: Colors.black87,
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile('gluten-free',
                    _glutenFree,
                    'Only include gluten-free meals.',
                    (newValue){
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }
                ),
                _buildSwitchListTile('lactose-free',
                    _lactoseFree,
                    'Only include lactose-free meals.',
                        (newValue){
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }
                ),
                _buildSwitchListTile('Vegetarian',
                    _vegeterian,
                    'Only include vegetarian meals.',
                        (newValue){
                      setState(() {
                        _vegeterian = newValue;
                      });
                    }
                ),
                _buildSwitchListTile('Vegan',
                    _vegan,
                    'Only include vegan meals.',
                        (newValue){
                      setState(() {
                        _vegan = newValue;
                      });
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
