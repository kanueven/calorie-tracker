import 'package:objectbox/objectbox.dart';
import 'package:calorie/model/food_item.dart';
import '../objectbox.g.dart';  // created by `flutter pub run build_runner build'


class ObjectBox {
  //store of the app
  late  Store store;
  late final Box<FoodItem> foodBox;

  ObjectBox._create(store){
    foodBox = Box<FoodItem> (store);

  }
  //create an instance of the objectBox
  static Future<ObjectBox> create() async{
    final store = await openStore();
    return ObjectBox._create(store);
  }

}