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

  //delete food item
//   void _deleteItems(FoodItem food) async {
//   if (food.id != 0) { // Check for a valid ID
//     objectBox.foodBox.remove(food.id);
//     _loadItems();
//   } else {
//     print("Invalid food ID: ${food.id}");
//   }
// }
  
  //method to call dialogbox
  void _showDialog(){

    final nameController = TextEditingController();
    final caloriesController = TextEditingController();

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
              _addFoodItems(name, calories);
            }
          },
        );
      },
    );
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: fooditems.length,
        itemBuilder: (context,index){
          final food = fooditems[index];
          return Card(
            child: ListTile(
            title: Text(food.name),
            subtitle: Text('${food.calories} calories'),
            
            trailing: Row(
              children: [
                IconButton(onPressed: ()=>
               {} , 
                icon: Icon(Icons.delete),color: Colors.red,)

            ],
            ),
            
            )
          );
          
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.blue,),
    );
  }
}