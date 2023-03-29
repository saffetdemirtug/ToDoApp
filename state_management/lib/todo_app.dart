import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/all_providers.dart';

import 'package:state_management/widgets/title_widget.dart';
import 'package:state_management/widgets/todo_list_item_widget.dart';
import 'package:state_management/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: "Bugün Neler Yapıyoruz?"),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
           ToolBarWidget(),
           allTodos.isEmpty ? const Center(child:  Text("Hadi görev ekle!",style: TextStyle(color: Colors.pinkAccent,fontSize: 35,fontWeight: FontWeight.w300),)): const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue( allTodos[i])
                ]
                
                ,child: const TodoListItemWidget()),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
            )
        ],
      ),
    );
  }
}
