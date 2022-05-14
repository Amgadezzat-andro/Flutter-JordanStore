import 'dart:async';

import 'package:generalshop/contracts/contracts.dart';

class DotsStream implements Disposable {
  int currentDot;

  final StreamController<int> _dotsStreamController =
      StreamController<int>.broadcast();
  Stream<int> get dots => _dotsStreamController.stream;
  StreamSink<int> get dotsSink => _dotsStreamController.sink;

  @override
  void dispose() {
    _dotsStreamController.close();
  }

  DotsStream() {
    currentDot = 1;
    _dotsStreamController.add(currentDot);
    _dotsStreamController.stream.listen(_indexChange);
  }

  void _indexChange(int newindex) {
    currentDot = newindex;
    _dotsStreamController.add(currentDot);
  }
}
