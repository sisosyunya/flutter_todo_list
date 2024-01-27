import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class AddTodoDialog extends HookConsumerWidget {
  final _todoController = TextEditingController();

  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _categoryValue = useState<String>('all');
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
            value: _categoryValue.value,
            onChanged: (value) {
              _categoryValue.value = value.toString();
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
            ref
                .read(todoListProvider.notifier)
                .add(_todoController.text, _categoryValue.value);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: TodoList(),
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

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) => TodoListNotifier(),
);

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
  (ref) => CategoryNotifier(),
);

class CategoryNotifier extends StateNotifier<List<String>> {
  CategoryNotifier() : super(['all']);

  void add(String category) {
    state = [
      ...state,
      category,
    ];
  }

  void remove(String category) {
    state = [
      for (final item in state)
        if (item != category) item,
    ];
  }
}

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

class Todo {
  final String title;
  final bool isDone;
  final String category;

  Todo({
    required this.title,
    this.isDone = false,
    required this.category,
  });
}

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todo = todoList[index];
        return ListTile(
          onTap: () {
            ref.read(todoListProvider.notifier).toggle(todo);
          },
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        );
      },
    );
  }
}
