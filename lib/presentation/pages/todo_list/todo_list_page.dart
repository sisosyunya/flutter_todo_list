import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo_category.dart';
import 'package:todolist/presentation/pages/todo_list/todo_list_card.dart';
import 'package:todolist/providers.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage(this.category, {Key? key}) : super(key: key);
  final TodoCategory category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    if (todoList.isEmpty) {
      return const Center(
        child: Text('タスクがありません'),
      );
    }
    if (category.name == 'all') {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return TodoListCard(todo);
        },
      );
    }
    if (category.name == 'done') {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          if (!todo.isDone) {
            return const SizedBox.shrink();
          }
          return TodoListCard(todo);
        },
      );
    }
    // category.name == todo.category.nameであるものだけ表示する
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todo = todoList[index];
        if (todo.category != category.name) {
          return const SizedBox.shrink();
        }
        return TodoListCard(todo);
      },
    );
  }
}
