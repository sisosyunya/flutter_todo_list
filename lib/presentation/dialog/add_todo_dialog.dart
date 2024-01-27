import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo.dart';
import 'package:todolist/domain/model/todo_category.dart';
import 'package:todolist/providers.dart';

class AddTodoDialog extends HookConsumerWidget {
  final _todoController = TextEditingController();

  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryValue = useState<String>('all');
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Column(
        children: [
          DropdownButton(
            items: ref.watch(categoryProvider).map((TodoCategory category) {
              return DropdownMenuItem(
                value: category.name,
                child: Text(category.name),
              );
            }).toList(),
            value: categoryValue.value,
            onChanged: (value) {
              categoryValue.value = value.toString();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextField(
              controller: _todoController,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(todoListProvider.notifier).add(Todo(
                  title: _todoController.text,
                  category: categoryValue.value,
                ));
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
