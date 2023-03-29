import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/all_providers.dart';

// ignore: must_be_immutable
class ToolBarWidget extends ConsumerWidget {
   ToolBarWidget({super.key});

  var _currentFilter = TodoListFilter.hepsi;
  Color changeTextColor(TodoListFilter filter) {
    return _currentFilter == filter ? Colors.pinkAccent : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tamamlanmamisTodoSayisi = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Center(
              child: Text(tamamlanmamisTodoSayisi == 0
                  ? "Görev Yok !"
                  : "${tamamlanmamisTodoSayisi.toString()}" " Görev Var",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            )),
        Tooltip(
          message: "Tüm görevler",
          child: TextButton(
            
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.hepsi;
              },
              child:  Text(
                "Hepsi",style: TextStyle(color: changeTextColor(TodoListFilter.hepsi),
                fontSize: 17
                ),
              )),
        ),
        Tooltip(
          
          message: "Tamamlanmayan görevleri listele",
          child: TextButton(
             
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.tamamlanmadi;
              },
              child:  Text("Tamamlanmadı",style: TextStyle(color: changeTextColor(TodoListFilter.tamamlanmadi),fontSize: 17),)),
        ),
        Tooltip(
          message: "Tamamlanan görevleri listele",
          child: TextButton(
            
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.tamamlandi;
              },
              child:  Text("Tamamlandı",style: TextStyle(color: changeTextColor(TodoListFilter.tamamlandi),fontSize: 17),)),
        ),
      ],
    );
  }
}
