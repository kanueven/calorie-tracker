import 'package:objectbox/objectbox.dart';

@Entity()
class FoodItem {
  @Id()
  int id = 0;
  String name;
  int calories;

  FoodItem({required this.calories, 
  required this.name});
}
