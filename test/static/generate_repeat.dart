import 'package:test/scaffolding.dart';
import 'package:text_gen/text_gen.dart';

final leaf = Random(
  possibilities: [
    Txt(text: 'a'),
    Txt(text: 'b'),
    Txt(text: 'c'),
  ],
);

final l0_0 = Random(possibilities: [leaf, leaf, leaf]);
final l0_1 = Random(possibilities: [l0_0, l0_0, l0_0]);
final l1 = Random(possibilities: [l0_1, l0_1, l0_1]);

final l2 = Capsule(encapsulated: [l1, l1, l1]);

final l3 = Capsule(encapsulated: [l2, l2, l2]);

void main() {
  const samples = 4096 * 2 * 2 * 2 * 2 * 2;
  const retries = 32;

  print('leaf: ${leaf.getDepth()}');
  print('l1: ${l1.getDepth()}');
  print('l2: ${l2.getDepth()}');
  print('l3: ${l3.getDepth()}');

  final l3sample = (l3.getDepth()).floor();

  final stopwatch = Stopwatch();

  for (var j = 0; j < retries; j++) {
    test('a', () {
      for (var i = 0; i < samples; i++) {
        stopwatch.start();
        l3.buildVariant(l3sample);
        stopwatch.stop();
      }
      print('${stopwatch.elapsedMilliseconds}ms for $samples samples');
      print(
          '${stopwatch.elapsedMicroseconds / (samples * (j + 1))}us per sample');
    });
  }
}
