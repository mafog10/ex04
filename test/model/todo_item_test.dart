part of todo_test_library;

void testTodoItems() {
  
  TodoList liste;
  
  group("Tests des items de todo", () {
    
    setUp(() {
      TodoListItemsModel model = new TodoListItemsModel();
      model.init();
      TodoLists listes = model.todoLists;
      liste = listes.find('TRV');
    });
    
    tearDown(() {
      liste.items.clear();
      expect(liste.items.isEmpty, isTrue);
    });
    
    test('Add TodoItem', () {
      TodoItem item = new TodoItem();
      item.code = '6';
      item.description = "Râcler les feuilles";
      bool added = liste.items.add(item);
      expect(added, isTrue);
      liste.items.display('Add TodoItem');
    });
    
    test('Add TodoItem without data', () {
      TodoItem item = new TodoItem();
      expect(item, isNotNull);
      bool added = liste.items.add(item);
      expect(added, isTrue);
      liste.items.display('Add TodoItem without data');
    });
    
    test('Add TodoItem with same code', () {
      TodoItem tdi = new TodoItem();
      tdi.description = "Chose à faire";
      tdi.code = '1';
      bool added = liste.items.add(tdi);
      expect(added, isFalse);
      liste.items.display('Add TodoItem with same code');
    });
    
    test('Find TodoItem by code', () {
      String searchCode = '3';
      TodoItem tdi = liste.items.find(searchCode);
      expect(tdi, isNotNull);
      expect(tdi.code, equals(searchCode));
      expect(tdi.description, equals('Ramasser les feuilles mortes'));
      tdi.display('Find TodoItem by code');
    });
    
    test('Order TodoItems by code', () {
      liste.items.order();
      liste.items.display('Order TodoItems by code');
    });
    
    test('Find TodoItem by partial description', () {
      liste.addItem('Nettoyer le salon');
      TodoItems items = liste.items.select(((x) => x.description.contains('salon')));
      expect(items.isEmpty, isFalse);
      expect(items.length, equals(2));
      items.display('Find TodoItem by partial description');
    });
    
    test('From TodoItems to JSON', () {
      List<Map<String, Object>> json = liste.items.toJson();
      expect(json, isNotNull);
      print('From TodoItem to JSON');
      print(json);
    });
    
    test('From JSON to TodoItems', () {
      List<Map<String, Object>> json = liste.items.toJson();
      liste.items.clear();
      expect(liste.items.isEmpty, isTrue);
      liste.items.fromJson(json);
      expect(liste.items.isEmpty, isFalse);
      liste.items.display('From JSON to TodoLists');
    });
    
  });
  
}