import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/domain/model/todo_category.dart';
import 'package:todolist/presentation/dialog/add_todo_dialog.dart';
import 'package:todolist/presentation/pages/todo_list/todo_list_page.dart';
import 'package:todolist/providers.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: 2 + ref.watch(categoryProvider).length);

    final categories = ref.watch(categoryProvider);

    useEffect(() => tabController.dispose, [categories]);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Todo List'),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              const Tab(
                text: 'All',
                icon: Icon(Icons.all_inbox),
              ),
              const Tab(
                text: 'Done',
                icon: Icon(Icons.done),
              ),
              ...categories.map((TodoCategory category) {
                return Tab(
                  text: category.name,
                  icon: category.icon,
                );
              }),
            ],
          )),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          TodoListPage(
              TodoCategory(name: 'all', icon: const Icon(Icons.all_inbox))),
          TodoListPage(
              TodoCategory(name: 'done', icon: const Icon(Icons.done))),
          ...categories.map((TodoCategory category) {
            return TodoListPage(category);
          }),
        ],
      ),
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
