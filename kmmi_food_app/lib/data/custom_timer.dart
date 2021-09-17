import 'dart:async';

class CustomTimer {
  var _second = 0;
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  CustomTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _controller.sink.add(_second);
      _second++;
    });
  }
}
