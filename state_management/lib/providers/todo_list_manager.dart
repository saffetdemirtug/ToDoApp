import 'package:riverpod/riverpod.dart';
import 'package:state_management/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager(super.state);

  void addTodo(String tanim) {
    var eklenecekTodo = TodoModel(id: const Uuid().v4(), tanim: tanim);

    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id, tanim: todo.tanim, tamamlandiMi: !todo.tamamlandiMi)
        else
          todo
    ];
  }

  void edit({required String id, required String yeniTanim}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id, tanim: yeniTanim, tamamlandiMi: todo.tamamlandiMi)
        else
          todo
    ];
  }

  void remove(TodoModel silinecekTodo) {
    state = state.where((element) => element.id != silinecekTodo.id).toList();
  }

  int tamamlanmamisTodoSayaci() {
    return state.where((element) => !element.tamamlandiMi).length;
  }
}
