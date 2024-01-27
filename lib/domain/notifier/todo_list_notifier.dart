import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void add(Todo todo) {
    state = [
      ...state,
      Todo(
        title: todo.title,
        isDone: todo.isDone,
        category: todo.category,
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

  void remove(Todo todo) {
    state = [
      for (final item in state)
        if (item != todo) item,
    ];
  }
}
