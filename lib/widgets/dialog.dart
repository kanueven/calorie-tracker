import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController caloriesController;
  final VoidCallback onAdd;
  final bool isEditing;

  const DialogBox({
    super.key,
    required this.nameController,
    required this.caloriesController,
    required this.onAdd,
     this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(isEditing? 'Edit Food Item':'Add Food Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Food Name'),
          ),
          TextField(
            controller: caloriesController,
            decoration: const InputDecoration(labelText: 'Calories'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final name = nameController.text;
            final calories = int.tryParse(caloriesController.text) ?? 0;

            if (name.isNotEmpty && calories > 0) {
              onAdd(); 
              Navigator.of(context).pop(); // Close the dialog
            } else {
              // Show an error if the input is invalid
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter valid data')),
              );
            }
          },
          child:  Text(isEditing ? 'Edit' : 'Add'),
        ),
      ],
    );
  }
}
