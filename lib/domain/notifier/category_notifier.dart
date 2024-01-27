import 'package:hooks_riverpod/hooks_riverpod.dart';

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
