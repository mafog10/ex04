part of todo_test_library;

void testTodoListItemsModel() {
  
  TodoLists modeleListes;
  
  group("Tests du modèle de todo", () {
    
    setUp(() {
      TodoListItemsModel model = new TodoListItemsModel();
      model.init();
      modeleListes = model.todoLists;
    });
    
    tearDown(() {
      modeleListes.clear();
      expect(modeleListes.isEmpty, isTrue);
    });
    
    test('Display model', () {
      modeleListes.display();
    });
    
  });
  
}