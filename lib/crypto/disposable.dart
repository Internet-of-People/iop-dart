import 'dart:async';

abstract class IDisposable {
  void dispose();
}

extension Disposable<T extends IDisposable> on T {
  static List<IDisposable> stack;

  FutureOr<R> use<R>(FutureOr<R> Function(T t) fn) {
    var synchronous = true;
    try {
      final res = fn(this);
      if (res is Future<R>) {
        synchronous = false;
        return res.whenComplete(() => dispose());
      } else {
        return res;
      }
    } finally {
      if (synchronous) {
        dispose();
      }
    }
  }
}
