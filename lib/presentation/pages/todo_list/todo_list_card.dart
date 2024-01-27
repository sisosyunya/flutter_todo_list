import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo.dart';
import 'package:todolist/providers.dart';

class TodoListCard extends ConsumerWidget {
  const TodoListCard(this.todo, {Key? key}) : super(key: key);
  final Todo todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(todo.title),
                  content: const Text('こちらのタスクを完了しますか？'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(todoListProvider.notifier).toggle(todo);
                        Navigator.pop(context);
                      },
                      child: const Text('完了'),
                    ),
                  ],
                );
              });
        },
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ref.read(todoListProvider.notifier).remove(todo);
          },
        ),
      ),
    );
  }
}
