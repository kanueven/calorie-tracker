import 'package:calorie/main.dart';
import 'package:calorie/model/food_item.dart';
import 'package:calorie/widgets/dialog.dart';
import 'package:flutter/material.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //fetch fooditems from list
  List<FoodItem> fooditems = [];

  //fetch filtered items
  List<FoodItem> filteredItems = [];


  final TextEditingController searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    searchController.addListener(_filteredItems);
    _loadItems();

  }
  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }
  //load items from the db
  void _loadItems() async{
    final items = objectBox.foodBox.getAll();
    setState(() {
      fooditems = items;
      filteredItems = items;
    });
  }
  //add items 
  void _addFoodItems(String name, int calories) async{
    final newFoodItem = FoodItem(calories: calories, name: name);
    objectBox.foodBox.put(newFoodItem);
  
    setState(() {
      fooditems.insert( 0, newFoodItem);
        filteredItems  = fooditems;
    });

  }
  //update food item
  void _updateItems(FoodItem food,String newName,int newCalories)async{
    food.calories = newCalories;
    food.name = newName;
    objectBox.foodBox.put(food);
    _loadItems();

  }
  //query,search filter
  void _filteredItems(){
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = fooditems.where((item) => item.name.toLowerCase().contains(query))
          .toList();
    });

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
          isEditing: food != null,
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
      appBar:AppBar(
        title: TextField(        
      controller: searchController,          
          decoration: InputDecoration(                                
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),  
            border:InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ) ,
      body: filteredItems.isEmpty 
      ? Center(child: Text('No items found'),)
     : ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context,index){
          final food = filteredItems[index];
          return Card(
            child: ListTile(
            title: Text(food.name),
            subtitle: Text('${food.calories} calories'),
            
            trailing: IconButton(onPressed: ()=> _deleteItems(food), icon: Icon(Icons.delete),color: Colors.red
            ,),
            onTap: () => _showDialog(food:food),
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