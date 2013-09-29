part of todo_library;

class TodoListItemsModel extends ConceptModel {
  
  static final String todoList = 'TodoList';

  Map<String, ConceptEntities> newEntries() {
    var todoLists = new TodoLists();
    var map = new Map<String, ConceptEntities>();
    map[todoList] = todoLists;
    return map;
  }

  TodoLists get todoLists => getEntry(todoList);

  init() {
    TodoList listeTravaux = new TodoList();
    listeTravaux.code = 'TRV';
    listeTravaux.title = 'Liste de travaux à compléter';
    todoLists.add(listeTravaux);
    
    listeTravaux.addItem('Peindre le salon');
    listeTravaux.addItem('Nettoyer les gouttières');
    listeTravaux.addItem('Ramasser les feuilles mortes');
    listeTravaux.addItem('Tailler la haie');
    listeTravaux.addItem("Balayer l'entrée");
    
    TodoList listeBureau = new TodoList();
    listeBureau.code = 'BUR';
    listeBureau.title = 'Liste de tâches à compléter au bureau';
    todoLists.add(listeBureau);
    
    listeBureau.addItem('Rédaction du compte-rendu de réunion');
    listeBureau.addItem('Compléter ma feuille de temps');
    listeBureau.addItem('Envoyer mon compte de dépenses');
    listeBureau.addItem('Préparer la présentation R-24');
    
    TodoList listeEcole = new TodoList();
    listeEcole.code = 'ECO';
    listeEcole.title = "Liste de choses à faire pour l'école";
    todoLists.add(listeEcole);
    
    listeEcole.addItem("Finir d'écrire le modèle");
    listeEcole.addItem('Coder les tests unitaires');
    listeEcole.addItem('Uploader sur Git');
    listeEcole.addItem('Mettre le prof comme collaborateur');
    listeEcole.addItem('Révision finale');
    
    TodoList listeEpicerie = new TodoList();
    listeEpicerie.code = 'EPI';
    listeEpicerie.title = "Liste d'épicerie";
    todoLists.add(listeEpicerie);
    
    listeEpicerie.addItem('Carottes');
    listeEpicerie.addItem('Patates');
    listeEpicerie.addItem('Navet');
    listeEpicerie.addItem('Céleri');
    listeEpicerie.addItem('Cubes de boeuf');
    listeEpicerie.addItem('Bouillon de boeuf');
    listeEpicerie.addItem('Farine');
    listeEpicerie.addItem('Jus de légumes');
    listeEpicerie.addItem('Frosted Flakes');
    listeEpicerie.addItem('Chips');
    listeEpicerie.addItem('Lait');
    listeEpicerie.addItem('Pain');
    listeEpicerie.addItem('Oeufs');
  }

  display() {
    print('TodoList Items Model');
    print('=============');
    for (TodoList tdl in todoLists) {
      print('  TodoList');
      print('  --------');
      print(tdl.toString());
      print('    Items');
      print('    -----');
      for (TodoItem tdi in tdl.items){
        print(tdi.toString());
      }
    }
    print(
        '============= ============= ============= '
        '============= ============= ============= '
    );
  }
  
}
