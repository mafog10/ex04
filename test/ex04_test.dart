library todo_test_library;

import 'package:unittest/unittest.dart';
import 'package:dartlero/dartlero.dart';
import 'package:ex04/todo_library.dart';

part 'model/todo_list_test.dart';
part 'model/todo_item_test.dart';
part 'model/todo_list_items_model_test.dart';

void main() {
  //Tester d'abord le modèle car il est la base des autres tests
  testTodoListItemsModel(); 
  
  //Tester les items car les tests des listes dépendent du bon fonctionnement des items
  testTodoItems(); 
  
  //Tests des listes, point d'entrée principal du modèle
  testTodoLists();
}
