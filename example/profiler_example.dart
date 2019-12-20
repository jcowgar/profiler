import 'package:profiler/profiler.dart';

void main() async {
  final p = Profiler();
  p.begin('initialization');
  await Future.delayed(Duration(seconds: 1));
  p.end();

  p.begin('execution');
  await Future.delayed(Duration(milliseconds: 1827));
  p.end();

  p.begin('initialization');
  await Future.delayed(Duration(microseconds: 192839));
  p.end();

  var report = p.report();

  for (final r in report) {
    print(r);
  }

  print('');

  final p2 = Profiler();
  p2.push('initialization');
  p2.act();
  p2.act();
  p2.act();
  await Future.delayed(Duration(seconds: 120));
  p2.push('execution');
  p2.act();
  await Future.delayed(Duration(milliseconds: 283));
  p2.pop();
  await Future.delayed(Duration(seconds: 178));

  for (final r in p2.report()) {
    print(r);
  }
}
