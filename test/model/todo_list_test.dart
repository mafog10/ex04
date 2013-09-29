part of todo_test_library;

void testTodoLists(){
  
  TodoLists listes;
  TodoList listeTest;
  
  group("Tests des listes de todo", () {
    
    setUp(() {
      TodoListItemsModel model = new TodoListItemsModel();
      model.init();
      listes = model.todoLists;
      listeTest = listes.find('TRV');
    });
    
    tearDown(() {
      listes.clear();
      expect(listes.isEmpty, isTrue);
    });
    
    test('Add TodoList', () {
      var tdl = new TodoList();
      expect(tdl, isNotNull);
      tdl.code = 'ADD';
      tdl.title = 'Liste ajoutée';
      bool added = listes.add(tdl);
      expect(added, isTrue);
      listes.display('Add TodoList');
    });
    
    test('Add TodoList Without Data', () {
      var tdl = new TodoList();
      expect(tdl, isNotNull);
      bool added = listes.add(tdl);
      expect(added, isTrue);
      listes.display('Add TodoList Without Data');
    });

    test('Add TodoList Not Unique', () {
      var tdl = new TodoList();
      expect(tdl, isNotNull);
      tdl.code = 'TRV';
      bool added = listes.add(tdl);
      expect(added, isFalse);
      listes.display('Add TodoList Not Unique');
    });
    
    test('Find TodoList by Dart code', () {
      var searchCode = 'ECO';
      var tdl = listes.find(searchCode);
      expect(tdl, isNotNull);
      expect(tdl.code, equals(searchCode));
      tdl.display('Find TodoList by Dart code');
    });
    
    test('Find TodoList by title', () {
      String searchedTitle = "Liste de choses à faire pour l'école";
      var tdls = listes.select(((x) => x.title == searchedTitle));
      expect(tdls.isEmpty, isFalse);
      expect(tdls.length, equals(1));
      tdls.display('Find TodoList by title');
    });
    
    test('Find TodoList by partial title then add', () {
      String searchedTitle = "école";
      var listesEcole = listes.select(((x) => x.title.contains(searchedTitle)));
      expect(listesEcole.isEmpty, isFalse);

      String titreNouvelleListe = "Livres à lire pour l'école";
      TodoList nouvelleListe = new TodoList();
      nouvelleListe.title = titreNouvelleListe;
      nouvelleListe.code = "LVR";
      
      bool added = listesEcole.add(nouvelleListe);
      expect(added, isTrue);
      listesEcole.display('Find TodoList by partial title then add');
      
      TodoList lst = listes.find("LVR");
      expect(lst, isNull);
      listes.display('Listes');
    });
    
    test('Find TodoList by partial title then remove', () {
      String searchedTitle = "école";
      int listCount = listes.length;
      listes.display('Listes before remove');
      var listesEcole = listes.select(((x) => x.title.contains(searchedTitle)));
      expect(listesEcole.isEmpty, isFalse);
      
      TodoList liste = listesEcole.find('ECO');
      expect(liste, isNotNull);
      expect(liste.title.contains(searchedTitle), isTrue);
      int listEcoleCount = listesEcole.length;
      listesEcole.remove(liste);
      expect(listesEcole.length, equals(--listEcoleCount));
      expect(listes.length, equals(listCount));
    });
    
    test('From TodoLists to JSON', () {
      List<Map<String, Object>> json = listes.toJson();
      expect(json, isNotNull);
      print(json);
    });
    
    test('From JSON to TodoLists', () {
      List<Map<String, Object>> json = listes.toJson();
      listes.clear();
      expect(listes.isEmpty, isTrue);
      listes.fromJson(json);
      expect(listes.isEmpty, isFalse);
      listes.display('From JSON to TodoLists');
    });
    
    test('Add item', () {
      int countBefore = listeTest.items.length;
      String newCode = listeTest.addItem('Passer à la quincaillerie');
      int countAfter = listeTest.items.length;
      expect(countAfter, equals(++countBefore));
      expect(newCode, equals((countAfter).toString()));
      listeTest.items.display('Add item');
    });
    
    test('Add item same description new code', () {
      int countBefore = listeTest.items.length;
      String newCode = listeTest.addItem('Peindre le salon');
      int countAfter = listeTest.items.length;
      expect(countAfter, equals(++countBefore));
      expect(newCode, equals((countAfter).toString()));
      listeTest.items.display('Add item same description new code');
    });
    
    test('Add item after cleanup - code resets', () {
      listeTest.items.clear();
      String newCode = listeTest.addItem('Laver les vitres');
      expect(newCode, equals('1'));
      expect(listeTest.items.length, equals(1));
      listeTest.items.display('Add item after cleanup - code resets');
    });
    
    test('Add item after clearing all completed - code resets', () {
      listeTest.completeAllOrReactivate();
      listeTest.clearCompletedItems();
      String newCode = listeTest.addItem('Laver les vitres');
      expect(newCode, equals('1'));
      expect(listeTest.items.length, equals(1));
      listeTest.items.display('Add item after clearing all completed - code resets');
    });

    test('Edit item', () {
      String newDescription = "Laver l'auto";
      listeTest.editItem('1', newDescription);
      expect(listeTest.items.find('1').description, equals(newDescription));
      listeTest.items.display('Edit item');
    });

    test('Edit item unknown code', () {
      String newDescription = "Faire une chose";
      listeTest.editItem('99', newDescription);
      expect(listeTest.items.find('99'), isNull);
      listeTest.items.display('Edit item unknown code');
    });
    
    test('Remove item', () {
      int countBefore = listeTest.items.length;
      int itemsRemoved = listeTest.removeItem('2');
      expect(listeTest.items.length, equals(--countBefore));
      expect(listeTest.items.find('2'), isNull);
      expect(itemsRemoved, equals(1));
      listeTest.items.display('Remove item');
    });

    test('Remove item unknown code', () {
      int countBefore = listeTest.items.length;
      int itemsRemoved = listeTest.removeItem('99');
      expect(listeTest.items.length, equals(countBefore));
      expect(listeTest.items.find('99'), isNull);
      expect(itemsRemoved, equals(0));
      listeTest.items.display('Remove item unknown code');
    });
    
    test('Switch completed', () {
      bool completed = listeTest.items.find('1').isCompleted;
      listeTest.switchCompleted('1');
      expect(completed != listeTest.items.find('1').isCompleted, isTrue);
      listeTest.items.find('1').display('Switch completed');
    });
    
  });
  
  
  group("Tests des listes de todo - statuts complétés", () {
    
    setUp(() {
      TodoListItemsModel model = new TodoListItemsModel();
      model.init();
      listes = model.todoLists;
      listeTest = listes.find('TRV');
      listeTest.switchCompleted('1');
      listeTest.switchCompleted('3');
      listeTest.switchCompleted('5');
      expect(listeTest.items.find('1').isCompleted, isTrue);
      expect(listeTest.items.find('3').isCompleted, isTrue);
      expect(listeTest.items.find('5').isCompleted, isTrue);
      expect(listeTest.items.find('2').isCompleted, isFalse);
      expect(listeTest.items.find('4').isCompleted, isFalse);
    });
    
    tearDown(() {
      listes.clear();
      expect(listes.isEmpty, isTrue);
    });
    
    test('Get list of active items', () {
      TodoItems activeItems = listeTest.getActiveItems();
      expect(activeItems.length, equals(2));
      activeItems.display('Get list of active items');
    });

    test('Get list of completed items', () {
      TodoItems completedItems = listeTest.getCompletedItems();
      expect(completedItems.length, equals(3));
      completedItems.display('Get list of completed items');
    });
    
    test('Clear list of completed items', () {
      TodoItems remainingItems = listeTest.clearCompletedItems();
      expect(remainingItems.length, equals(2));
      expect(remainingItems.length, equals(listeTest.getActiveItems().length));
      remainingItems.display('Clear list of completed items');
    });

    test('Complete all from many status', () {
      TodoItems allComplete = listeTest.completeAllOrReactivate();
      expect(allComplete.length, equals(listeTest.getCompletedItems().length));
      expect(listeTest.getActiveItems().length, equals(0));
      allComplete.display('Complete all from many status');
    });
    
    test('Reactivate all from all completed', () {
      listeTest.completeAllOrReactivate(); //tous complétés
      TodoItems allActive = listeTest.completeAllOrReactivate(); //tous réactivés
      expect(allActive.length, equals(listeTest.getActiveItems().length));
      expect(listeTest.getCompletedItems().length, equals(0));
      allActive.display('Reactivate all from all completed');
    });
    
    test('Complete all from all active', () {
      listeTest.completeAllOrReactivate(); //Complète tous
      listeTest.completeAllOrReactivate(); //Réactive tous
      TodoItems allComplete = listeTest.completeAllOrReactivate(); //Tous complétés
      expect(allComplete.length, equals(listeTest.getCompletedItems().length));
      expect(listeTest.getActiveItems().length, equals(0));
      allComplete.display('Complete all from all active');
    });
    
    test('Display count', () {
      expect(listeTest.displayRemainingCount(), equals("2 items left"));
      print('Display count: ' + listeTest.displayRemainingCount() + '\n');
    });
    
    test('Display count one singular', () {
      listeTest.switchCompleted('4');
      expect(listeTest.displayRemainingCount(), equals("1 item left"));
      print('Display count one singular: ' + listeTest.displayRemainingCount() + '\n');
    });
    
  });
  
}

