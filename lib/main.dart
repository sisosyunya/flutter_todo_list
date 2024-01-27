import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo.dart';
import 'package:todolist/presentation/pages/todo_list_page.dart';
import 'package:todolist/providers.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MyHomePage(),
    );
  }
}

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
            items: ref.watch(categoryProvider).map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
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

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: const TodoListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
