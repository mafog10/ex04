part of todo_library;

class TodoList extends ConceptEntity<TodoList> {
  
  String title;
  int _nextId = 0; //Utilisé pour auto-générer un code aux items de la liste
  TodoItems items = new TodoItems();
  
  TodoList newEntity() => new TodoList();
  
  String toString() {
    return '  {\n '
           '    ${super.toString()}, \n '
           '    title: ${title}\n'
           '  }\n';
  }
  
  Map<String, Object> toJson() {
    Map<String, Object> entityMap = super.toJson();
    entityMap['title'] = title;
    entityMap['_nextId'] = _nextId;
    entityMap['items'] = items.toJson();
    return entityMap;
  }

  fromJson(Map<String, Object> entityMap) {
    super.fromJson(entityMap);
    title = entityMap['title'];
    _nextId = entityMap['_nextId'];
    items.fromJson(entityMap['items']);
  }
  
  int compareTo(TodoList other) {
    return code.compareTo(other.code);
  }
  
  /**
   * Crée un item actif ayant la [description] fournie
   * et retourne le code lui ayant été auto-généré
   */
  String addItem(String description) {
    if (items.length == 0){
      _nextId = 1;
    }
    TodoItem item = new TodoItem();
    item.description = description;
    item.code = _nextId.toString();
    _nextId++;
    items.add(item);
    return (_nextId - 1).toString();
  }
  
  void editItem(String code, String newDescription) {
    TodoItem item = items.find(code);
    if (item != null) {
      item.description = newDescription;
    }
  }
  
  /**
   * Enlève de la liste d'items celui ayant le [code] fourni.
   * Retourne 1 si un item a été enlevé, 0 sinon.
   */
  int removeItem(String code) {
    TodoItem item = items.find(code);
    if (item != null) {
      items.remove(item);
      return 1;
    }
    return 0;
  }
  
  void switchCompleted(String code) {
    TodoItem item = items.find(code);
    if (item != null) {
      item.isCompleted = !item.isCompleted;
    }
  }
  
  TodoItems getActiveItems() => 
      items.select(((x) => !x.isCompleted));

  TodoItems getCompletedItems()  => 
      items.select(((x) => x.isCompleted));
  
  TodoItems clearCompletedItems() {
    items = items.select(((x) => !x.isCompleted));
    return items;
  }
  
  /**
   * S'il les items ne sont pas tous complétés, les complète tous, sinon les met tous actifs.
   */
  TodoItems completeAllOrReactivate() {
    if (items.every(((x) => x.isCompleted))){
      items.forEach((x) => (x.isCompleted = false));
    }
    else {
      items.forEach((x) =>(x.isCompleted = true));
    }
    return items;
  }
  
  String displayRemainingCount () {
    int remaining = items.select(((x) => !x.isCompleted)).length;
    if (remaining == 1) {
      return remaining.toString() +" item left"; //au singulier
    }
    else {
      return remaining.toString() +" items left";
    }
  }
}


class TodoLists extends ConceptEntities<TodoList> {
  TodoLists newEntities() => new TodoLists();
  TodoList newEntity() => new TodoList();
}


