import 'dart:async';

abstract class BaseBloc {
  void dispose();
}

class CounterBloc extends BaseBloc {
  final _controller = StreamController<int>();
  get _counter => _controller.sink;
  get counter => _controller.stream;

  void increment(int count){
    _counter.add(++count);
  }
  void dispose() {
    _controller.close();
  }
}
