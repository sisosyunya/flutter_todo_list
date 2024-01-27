import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/notifier/category_notifier.dart';
import 'package:todolist/domain/notifier/todo_list_notifier.dart';

import 'domain/model/todo.dart';

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) => TodoListNotifier(),
);

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
  (ref) => CategoryNotifier(),
);
