part of todo_library;

class TodoItem extends ConceptEntity<TodoItem> {
  
  String description;
  bool isCompleted = false;
  
  TodoItem newEntity() => new TodoItem();
  
  String toString(){
    return '    {\n '
           '      ${super.toString()}, \n '
           '      description: ${description}, \n '
           '      isCompleted: ${isCompleted}\n'
           '    }\n';
  }
  
  Map<String, Object> toJson() {
    Map<String, Object> entityMap = super.toJson();
    entityMap['description'] = description;
    entityMap['isCompleted'] = isCompleted;
    return entityMap;
  }
  
  fromJson(Map<String, Object> entityMap) {
    super.fromJson(entityMap);
    description = entityMap['description'];
    isCompleted = entityMap['isCompleted'];
  }
  
  int compareTo(TodoItem other) {
    return code.compareTo(other.code); //pour tri par ordre de création
  }
  
  void markCompleted() { 
    isCompleted = true;
  }
  
}

class TodoItems extends ConceptEntities<TodoItem> {
  TodoItems newEntities() => new TodoItems();
  TodoItem newEntity() => new TodoItem();
}