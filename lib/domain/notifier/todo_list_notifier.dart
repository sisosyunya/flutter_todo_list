
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void add(String title, String category) {
    state = [
      ...state,
      Todo(
        title: title,
        category: category,
      ),
    ];
  }

  void toggle(Todo todo) {
    state = [
      for (final item in state)
        if (item == todo)
          Todo(
            title: item.title,
            isDone: !item.isDone,
            category: item.category,
          )
        else
          item,
    ];
  }
}
