
import 'package:riverpod/riverpod.dart';
import 'package:state_management/models/todo_model.dart';
import 'package:uuid/uuid.dart';

import 'todo_list_manager.dart';

enum TodoListFilter {
  hepsi,
  tamamlanmadi,
  tamamlandi,
}

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.hepsi);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), tanim: "Spora git (Test Görev)"),
    TodoModel(id: const Uuid().v4(), tanim: "Alışveriş yap (Test Görev)"),
    TodoModel(id: const Uuid().v4(), tanim: "Tiyatroya git (Test Görev)"),
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.hepsi:
      return todoList;

    case TodoListFilter.tamamlandi:
      return todoList.where((element) => element.tamamlandiMi).toList();

    case TodoListFilter.tamamlanmadi:
      return todoList.where((element) => !element.tamamlandiMi).toList();
  }
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodos = ref.watch(todoListProvider);
  final count = allTodos.where((element) => !element.tamamlandiMi).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
