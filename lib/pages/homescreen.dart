import 'package:calorie/main.dart';
import 'package:calorie/model/food_item.dart';
import 'package:calorie/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //fetch fooditems from list
  List<FoodItem> fooditems = [];

  @override
  void initState(){
    super.initState();
    _loadItems();

  }
  //load items from the db
  void _loadItems() async{
    final items = objectBox.foodBox.getAll();
    setState(() {
      fooditems = items;
    });
  }
  //add items 
  void _addFoodItems(String name, int calories) async{
    final newFoodItem = FoodItem(calories: calories, name: name);
    objectBox.foodBox.put(newFoodItem);
  
    _loadItems();

  }
  //update food item
  void _updateItems(FoodItem food,String newName,int newCalories)async{
    food.calories = newCalories;
    food.name = newName;
    objectBox.foodBox.put(food);
    _loadItems();

  }

  //delete food item
  void _deleteItems(FoodItem food) async {
  if (food.id != 0) { // Check for a valid ID
    objectBox.foodBox.remove(food.id);
    print('deleted fooditem');
    _loadItems();
  } else {
    print("Invalid food ID: ${food.id}");
  }
}
  
  //method to call dialogbox
  void _showDialog({FoodItem ?food}){

    final nameController = TextEditingController();
    final caloriesController = TextEditingController();

    if (food != null) {
      nameController.text = food.name;
      caloriesController.text = food.calories.toString();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          nameController: nameController,
          caloriesController: caloriesController,
          onAdd: () {
            final name = nameController.text;
            final calories = int.tryParse(caloriesController.text) ?? 0;
            if (name.isNotEmpty && calories > 0) {
             if (food!= null){
              _updateItems(food, name, calories);
             }else{
               _addFoodItems(name, calories);
             }
            }
          },
        );
      },
    );
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fooditems.isEmpty 
      ? Center(child: Text('No items found'),)
     : ListView.builder(
        itemCount: fooditems.length,
        itemBuilder: (context,index){
          final food = fooditems[index];
          return Card(
            child: ListTile(
            title: Text(food.name),
            subtitle: Text('${food.calories} calories'),
            
            trailing: IconButton(onPressed: ()=> _deleteItems(food), icon: Icon(Icons.delete),color: Colors.red
            ,),
            onTap: () => _showDialog(),
            ),
            
          );
          
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.blue,),
    );
  }
}