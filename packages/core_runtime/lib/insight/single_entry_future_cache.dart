import 'dart:async';

class SingleEntryFutureCache<T extends Object> {
  String? _key;
  Future<T?>? _future;

  Future<T?> get(String key, Future<T?> Function() load) async {
    final cached = _future;
    if (_key == key && cached != null) return cached;

    final future = Future<T?>.sync(load);
    _key = key;
    _future = future;
    try {
      final result = await future;
      if (result == null && identical(_future, future)) clear();
      return result;
    } on Object {
      if (identical(_future, future)) clear();
      rethrow;
    }
  }

  void clear() {
    _key = null;
    _future = null;
  }
}
