import '../lib/profiler.dart';

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

  for (final r in p.report()) {
    print(r);
  }

  print('');

  final p2 = Profiler();
  p2.push('initialization');
  p2.act();
  p2.act();
  p2.act();
  await Future.delayed(Duration(seconds: 12));
  p2.push('execution');
  p2.act();
  await Future.delayed(Duration(milliseconds: 283));
  p2.pop();
  await Future.delayed(Duration(seconds: 1));

  for (final r in p2.report()) {
    print(r);
  }

  final p3 = Profiler();
  await p3.profile('Hello World', () async {
    await Future.delayed(Duration(seconds: 3));
  });

  for (final r in p3.report()) {
    print(r);
  }
}
