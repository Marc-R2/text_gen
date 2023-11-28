import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('integration', () {
    group('Random - Simple', () {
      late EditableRandom rand;

      setUpAll(() {
        rand = EditableRandom(
          possibilities: [
            EditableTxt(text: 'ABC'),
            EditableTxt(text: 'DEF'),
            EditableTxt(text: 'HIJ'),
          ],
        );
      });

      test('Depth', () => expect(rand.getDepth(), 3));

      test('Random(0) => ABC', () => expect(rand.buildVariant(0), 'ABC'));
      test('Random(1) => DEF', () => expect(rand.buildVariant(1), 'DEF'));
      test('Random(2) => HIJ', () => expect(rand.buildVariant(2), 'HIJ'));
      test('Random(3) => null', () => expect(rand.buildVariant(3), null));
    });

    group('Capsule - Simple', () {
      late EditableCapsule cap;

      setUpAll(() {
        cap = EditableCapsule(
          encapsulated: [
            EditableTxt(text: 'ABC'),
            EditableTxt(text: 'DEF'),
            EditableTxt(text: 'HIJ'),
          ],
        );
      });

      test('Depth', () => expect(cap.getDepth(), 1));

      test('Capsule(0)', () => expect(cap.buildVariant(0), 'ABC DEF HIJ'));
      test('Capsule(1) => null', () => expect(cap.buildVariant(1), null));
      test('Capsule(2) => null', () => expect(cap.buildVariant(2), null));
      test('Capsule(3) => null', () => expect(cap.buildVariant(3), null));
    });

    group('Capsule(Txt Random(3) Txt)', () {
      late EditableCapsule cap;

      setUpAll(() {
        cap = EditableCapsule(
          encapsulated: [
            EditableTxt(text: 'ABC'),
            EditableRandom(
              possibilities: [
                EditableTxt(text: 'AB'),
                EditableTxt(text: 'CD'),
                EditableTxt(text: 'EF'),
              ],
            ),
            EditableTxt(text: 'HIJ'),
          ],
        );
      });

      test('Depth', () => expect(cap.getDepth(), 3));

      test(
        'Capsule(Txt Random(3) Txt)(0)',
        () => expect(cap.buildVariant(0), 'ABC AB HIJ'),
      );

      test(
        'Capsule(Txt Random(3) Txt)(1)',
        () => expect(cap.buildVariant(1), 'ABC CD HIJ'),
      );

      test(
        'Capsule(Txt Random(3) Txt)(2)',
        () => expect(cap.buildVariant(2), 'ABC EF HIJ'),
      );

      test(
        'Capsule(Txt Random(3) Txt)(3) => null',
        () => expect(cap.buildVariant(3), null),
      );
    });

    group('Capsule(Random(3) Random(3))', () {
      late EditableCapsule cap;

      setUpAll(() {
        cap = EditableCapsule(
          encapsulated: [
            EditableRandom(
              possibilities: [
                EditableTxt(text: 'AB'),
                EditableTxt(text: 'CD'),
                EditableTxt(text: 'EF'),
              ],
            ),
            EditableRandom(
              possibilities: [
                EditableTxt(text: 'GH'),
                EditableTxt(text: 'IJ'),
                EditableTxt(text: 'KL'),
              ],
            ),
          ],
        );
      });

      test('Depth', () => expect(cap.getDepth(), 9));

      test(
        'Capsule(Random(3) Random(3))(0)',
        () => expect(cap.buildVariant(0), 'AB GH'),
      );

      test(
        'Capsule(Random(3) Random(3))(1)',
        () => expect(cap.buildVariant(1), 'CD GH'),
      );

      test(
        'Capsule(Random(3) Random(3))(2)',
        () => expect(cap.buildVariant(2), 'EF GH'),
      );

      test(
        'Capsule(Random(3) Random(3))(3)',
        () => expect(cap.buildVariant(3), 'AB IJ'),
      );

      test(
        'Capsule(Random(3) Random(3))(4)',
        () => expect(cap.buildVariant(4), 'CD IJ'),
      );

      test(
        'Capsule(Random(3) Random(3))(5)',
        () => expect(cap.buildVariant(5), 'EF IJ'),
      );

      test(
        'Capsule(Random(3) Random(3))(6)',
        () => expect(cap.buildVariant(6), 'AB KL'),
      );

      test(
        'Capsule(Random(3) Random(3))(7)',
        () => expect(cap.buildVariant(7), 'CD KL'),
      );

      test(
        'Capsule(Random(3) Random(3))(8)',
        () => expect(cap.buildVariant(8), 'EF KL'),
      );

      test(
        'Capsule(Random(3) Random(3))(9) => null',
        () => expect(cap.buildVariant(9), null),
      );
    });

    group('Capsule(Txt Random(3) Random(3) Txt)', () {
      late EditableCapsule cap;

      setUpAll(() {
        cap = EditableCapsule(
          encapsulated: [
            EditableTxt(text: 'ABC'),
            EditableRandom(
              possibilities: [
                EditableTxt(text: 'AB'),
                EditableTxt(text: 'CD'),
                EditableTxt(text: 'EF'),
              ],
            ),
            EditableRandom(
              possibilities: [
                EditableTxt(text: 'GH'),
                EditableTxt(text: 'IJ'),
                EditableTxt(text: 'KL'),
              ],
            ),
            EditableTxt(text: 'HIJ'),
          ],
        );
      });

      test('Depth', () => expect(cap.getDepth(), 9));

      test(
        'C(T R(3) R(3) T)(0)',
        () => expect(cap.buildVariant(0), 'ABC AB GH HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(1)',
        () => expect(cap.buildVariant(1), 'ABC CD GH HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(2)',
        () => expect(cap.buildVariant(2), 'ABC EF GH HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(3)',
        () => expect(cap.buildVariant(3), 'ABC AB IJ HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(4)',
        () => expect(cap.buildVariant(4), 'ABC CD IJ HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(5)',
        () => expect(cap.buildVariant(5), 'ABC EF IJ HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(6)',
        () => expect(cap.buildVariant(6), 'ABC AB KL HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(7)',
        () => expect(cap.buildVariant(7), 'ABC CD KL HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(8)',
        () => expect(cap.buildVariant(8), 'ABC EF KL HIJ'),
      );

      test(
        'C(T R(3) R(3) T)(9) => null',
        () => expect(cap.buildVariant(9), null),
      );
    });

    group('C(R(C(R(3) R(3)) C(R(3) R(3)))', () {
      late EditableCapsule cap;

      setUpAll(() {
        cap = EditableCapsule(
          encapsulated: [
            EditableRandom(
              possibilities: [
                EditableCapsule(
                  encapsulated: [
                    EditableRandom(
                      possibilities: [
                        EditableTxt(text: 'AB'),
                        EditableTxt(text: 'CD'),
                        EditableTxt(text: 'EF'),
                      ],
                    ),
                    EditableRandom(
                      possibilities: [
                        EditableTxt(text: 'GH'),
                        EditableTxt(text: 'IJ'),
                        EditableTxt(text: 'KL'),
                      ],
                    ),
                  ],
                ),
                EditableCapsule(
                  encapsulated: [
                    EditableRandom(
                      possibilities: [
                        EditableTxt(text: 'MN'),
                        EditableTxt(text: 'OP'),
                        EditableTxt(text: 'QR'),
                      ],
                    ),
                    EditableRandom(
                      possibilities: [
                        EditableTxt(text: 'ST'),
                        EditableTxt(text: 'UV'),
                        EditableTxt(text: 'WX'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      });

      test('Depth', () => expect(cap.getDepth(), 18));

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(0)',
        () => expect(cap.buildVariant(0), 'AB GH'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(1)',
        () => expect(cap.buildVariant(1), 'CD GH'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(2)',
        () => expect(cap.buildVariant(2), 'EF GH'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(3)',
        () => expect(cap.buildVariant(3), 'AB IJ'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(4)',
        () => expect(cap.buildVariant(4), 'CD IJ'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(5)',
        () => expect(cap.buildVariant(5), 'EF IJ'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(6)',
        () => expect(cap.buildVariant(6), 'AB KL'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(7)',
        () => expect(cap.buildVariant(7), 'CD KL'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(8)',
        () => expect(cap.buildVariant(8), 'EF KL'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(9)',
        () => expect(cap.buildVariant(9), 'MN ST'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(10)',
        () => expect(cap.buildVariant(10), 'OP ST'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(11)',
        () => expect(cap.buildVariant(11), 'QR ST'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(12)',
        () => expect(cap.buildVariant(12), 'MN UV'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(13)',
        () => expect(cap.buildVariant(13), 'OP UV'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(14)',
        () => expect(cap.buildVariant(14), 'QR UV'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(15)',
        () => expect(cap.buildVariant(15), 'MN WX'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(16)',
        () => expect(cap.buildVariant(16), 'OP WX'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(17)',
        () => expect(cap.buildVariant(17), 'QR WX'),
      );

      test(
        'C(R(C(R(3) R(3)) C(R(3) R(3)))(18)',
        () => expect(cap.buildVariant(18), null),
      );
    });
  });
}
