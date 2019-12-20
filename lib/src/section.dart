class Section {
  final String section;
  final Stopwatch stopwatch;
  int count = 0;

  Section(this.section) : stopwatch = Stopwatch();

  void stop() {
    stopwatch.stop();
  }

  void start() {
    stopwatch.start();
  }

  void act() {
    count++;
  }

  @override
  String toString() {
    if (count > 0) {
      final per =
          Duration(microseconds: stopwatch.elapsedMicroseconds ~/ count);
      return '$section: $count actions in ${stopwatch.elapsed}, ${per}/per';
    }

    return '$section: ${stopwatch.elapsed}';
  }
}
