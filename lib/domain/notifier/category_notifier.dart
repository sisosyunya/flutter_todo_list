import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo_category.dart';

class CategoryNotifier extends StateNotifier<List<TodoCategory>> {
  CategoryNotifier() : super([]);

  void add(TodoCategory category) {
    state = [
      ...state,
      category,
    ];
  }

  void remove(TodoCategory category) {
    state = [
      for (final item in state)
        if (item != category) item,
    ];
  }
}
