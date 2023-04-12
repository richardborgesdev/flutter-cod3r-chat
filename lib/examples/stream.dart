import 'dart:async';

void main(List<String> args) {
  final s = buildPeriodicStream();

  s.listen((event) {
    print('value is $event');
  });
}

Stream buildPeriodicStream() {
  return Stream<int>.periodic(
    Duration(seconds: 2),
    (index) => index + 1,
  ).take(10);
}

Stream buildMultiStream() {
  return Stream<int>.multi((controller) {
    controller.add(1);
    controller.add(2);
    controller.add(3);

    Timer.periodic(
      Duration(seconds: 2),
      (_) => controller.add(1),
    );
  });
}
