import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Random - Simple', () {
    late Random rand;

    setUpAll(() {
      rand = Random(possibilities: [
        Txt(text: 'ABC'),
        Txt(text: 'DEF'),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(rand.getDepth(), 3));

    test('Random(0) => ABC', () => expect(rand.buildVariant(0), 'ABC'));
    test('Random(1) => DEF', () => expect(rand.buildVariant(1), 'DEF'));
    test('Random(2) => HIJ', () => expect(rand.buildVariant(2), 'HIJ'));
    test('Random(3) => null', () => expect(rand.buildVariant(3), null));
  });

  group('Capsule - Simple', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Txt(text: 'ABC'),
        Txt(text: 'DEF'),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 1));

    test('Random(0) => ABC', () => expect(cap.buildVariant(0), 'ABC DEF HIJ'));
    test('Random(1) => null', () => expect(cap.buildVariant(1), null));
    test('Random(2) => null', () => expect(cap.buildVariant(2), null));
    test('Random(3) => null', () => expect(cap.buildVariant(3), null));
  });

  group('Capsule(Txt Random(3) Txt)', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Txt(text: 'ABC'),
        Random(possibilities: [
          Txt(text: 'AB'),
          Txt(text: 'CD'),
          Txt(text: 'EF'),
        ]),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 3));

    test('Capsule(Txt Random(3) Txt)(0)',
            () => expect(cap.buildVariant(0), 'ABC AB HIJ'));
    test('Capsule(Txt Random(3) Txt)(1)',
            () => expect(cap.buildVariant(1), 'ABC CD HIJ'));
    test('Capsule(Txt Random(3) Txt)(2)',
            () => expect(cap.buildVariant(2), 'ABC EF HIJ'));
    test('Capsule(Txt Random(3) Txt)(3) => null',
            () => expect(cap.buildVariant(3), null));
  });

  group('Capsule(Random(3) Random(3))', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Random(possibilities: [
          Txt(text: 'AB'),
          Txt(text: 'CD'),
          Txt(text: 'EF'),
        ]),
        Random(possibilities: [
          Txt(text: 'GH'),
          Txt(text: 'IJ'),
          Txt(text: 'KL'),
        ]),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 9));

    test('Capsule(Random(3) Random(3))(0)',
            () => expect(cap.buildVariant(0), 'AB GH'));
    test('Capsule(Random(3) Random(3))(1)',
            () => expect(cap.buildVariant(1), 'CD GH'));
    test('Capsule(Random(3) Random(3))(2)',
            () => expect(cap.buildVariant(2), 'EF GH'));
    test('Capsule(Random(3) Random(3))(3)',
            () => expect(cap.buildVariant(3), 'AB IJ'));
    test('Capsule(Random(3) Random(3))(4)',
            () => expect(cap.buildVariant(4), 'CD IJ'));
    test('Capsule(Random(3) Random(3))(5)',
            () => expect(cap.buildVariant(5), 'EF IJ'));
    test('Capsule(Random(3) Random(3))(6)',
            () => expect(cap.buildVariant(6), 'AB KL'));
    test('Capsule(Random(3) Random(3))(7)',
            () => expect(cap.buildVariant(7), 'CD KL'));
    test('Capsule(Random(3) Random(3))(8)',
            () => expect(cap.buildVariant(8), 'EF KL'));
    test('Capsule(Random(3) Random(3))(9) => null',
            () => expect(cap.buildVariant(9), null));
  });

  group('Capsule(Txt Random(3) Random(3) Txt)', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Txt(text: 'ABC'),
        Random(possibilities: [
          Txt(text: 'AB'),
          Txt(text: 'CD'),
          Txt(text: 'EF'),
        ]),
        Random(possibilities: [
          Txt(text: 'GH'),
          Txt(text: 'IJ'),
          Txt(text: 'KL'),
        ]),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 9));

    test('C(T R(3) R(3) T)(0)', () => expect(cap.buildVariant(0), 'ABC AB GH HIJ'));
    test('C(T R(3) R(3) T)(1)', () => expect(cap.buildVariant(1), 'ABC CD GH HIJ'));
    test('C(T R(3) R(3) T)(2)', () => expect(cap.buildVariant(2), 'ABC EF GH HIJ'));
    test('C(T R(3) R(3) T)(3)', () => expect(cap.buildVariant(3), 'ABC AB IJ HIJ'));
    test('C(T R(3) R(3) T)(4)', () => expect(cap.buildVariant(4), 'ABC CD IJ HIJ'));
    test('C(T R(3) R(3) T)(5)', () => expect(cap.buildVariant(5), 'ABC EF IJ HIJ'));
    test('C(T R(3) R(3) T)(6)', () => expect(cap.buildVariant(6), 'ABC AB KL HIJ'));
    test('C(T R(3) R(3) T)(7)', () => expect(cap.buildVariant(7), 'ABC CD KL HIJ'));
    test('C(T R(3) R(3) T)(8)', () => expect(cap.buildVariant(8), 'ABC EF KL HIJ'));
    test('C(T R(3) R(3) T)(9) => null', () => expect(cap.buildVariant(9), null));
  });

  group('C(R(C(R(3) R(3)) C(R(3) R(3)))', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Random(possibilities: [
          Capsule(encapsulated: [
            Random(possibilities: [
              Txt(text: 'AB'),
              Txt(text: 'CD'),
              Txt(text: 'EF'),
            ]),
            Random(possibilities: [
              Txt(text: 'GH'),
              Txt(text: 'IJ'),
              Txt(text: 'KL'),
            ]),
          ]),
          Capsule(encapsulated: [
            Random(possibilities: [
              Txt(text: 'MN'),
              Txt(text: 'OP'),
              Txt(text: 'QR'),
            ]),
            Random(possibilities: [
              Txt(text: 'ST'),
              Txt(text: 'UV'),
              Txt(text: 'WX'),
            ]),
          ]),
        ]),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 18));

    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(0)', () => expect(cap.buildVariant(0), 'AB GH'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(1)', () => expect(cap.buildVariant(1), 'CD GH'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(2)', () => expect(cap.buildVariant(2), 'EF GH'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(3)', () => expect(cap.buildVariant(3), 'AB IJ'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(4)', () => expect(cap.buildVariant(4), 'CD IJ'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(5)', () => expect(cap.buildVariant(5), 'EF IJ'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(6)', () => expect(cap.buildVariant(6), 'AB KL'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(7)', () => expect(cap.buildVariant(7), 'CD KL'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(8)', () => expect(cap.buildVariant(8), 'EF KL'));

    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(9)', () => expect(cap.buildVariant(9), 'MN ST'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(10)', () => expect(cap.buildVariant(10), 'OP ST'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(11)', () => expect(cap.buildVariant(11), 'QR ST'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(12)', () => expect(cap.buildVariant(12), 'MN UV'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(13)', () => expect(cap.buildVariant(13), 'OP UV'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(14)', () => expect(cap.buildVariant(14), 'QR UV'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(15)', () => expect(cap.buildVariant(15), 'MN WX'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(16)', () => expect(cap.buildVariant(16), 'OP WX'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(17)', () => expect(cap.buildVariant(17), 'QR WX'));
    test('C(R(C(R(3) R(3)) C(R(3) R(3)))(18)', () => expect(cap.buildVariant(18), null));

  });

  /// Test the permutation function in the Capsule class
  group('Capsule.permutation', () {
    group('1 List', () {
      late List<String> list;

      setUpAll(() {
        list = ['A', 'B', 'C'];
      });

      test('1 List(0)', () {
        final List<String> res = Capsule.permutation(0, [list]);
        print(res);
        expect(res, ['A']);
      });

      test('1 List(1)', () {
        final List<String> res = Capsule.permutation(1, [list]);
        print(res);
        expect(res, ['B']);
      });

      test('1 List(2)', () {
        final List<String> res = Capsule.permutation(2, [list]);
        print(res);
        expect(res, ['C']);
      });
    });

    group('2 Lists', () {
      late List<String> list1;
      late List<String> list2;

      setUpAll(() {
        list1 = ['A', 'B', 'C'];
        list2 = ['D', 'E', 'F'];
      });

      test('2 Lists(0)', () {
        final List<String> res = Capsule.permutation(0, [list1, list2]);
        print(res);
        expect(res, ['A', 'D']);
      });

      test('2 Lists(1)', () {
        final List<String> res = Capsule.permutation(1, [list1, list2]);
        print(res);
        expect(res, ['B', 'D']);
      });

      test('2 Lists(2)', () {
        final List<String> res = Capsule.permutation(2, [list1, list2]);
        print(res);
        expect(res, ['C', 'D']);
      });

      test('2 Lists(3)', () {
        final List<String> res = Capsule.permutation(3, [list1, list2]);
        print(res);
        expect(res, ['A', 'E']);
      });

      test('2 Lists(4)', () {
        final List<String> res = Capsule.permutation(4, [list1, list2]);
        print(res);
        expect(res, ['B', 'E']);
      });

      test('2 Lists(5)', () {
        final List<String> res = Capsule.permutation(5, [list1, list2]);
        print(res);
        expect(res, ['C', 'E']);
      });

      test('2 Lists(6)', () {
        final List<String> res = Capsule.permutation(6, [list1, list2]);
        print(res);
        expect(res, ['A', 'F']);
      });

      test('2 Lists(7)', () {
        final List<String> res = Capsule.permutation(7, [list1, list2]);
        print(res);
        expect(res, ['B', 'F']);
      });

      test('2 Lists(8)', () {
        final List<String> res = Capsule.permutation(8, [list1, list2]);
        print(res);
        expect(res, ['C', 'F']);
      });

      test('2 Lists(9)', () {
        final List<String> res = Capsule.permutation(9, [list1, list2]);
        print(res);
        expect(res, ['A', 'D']);
      });
    });

    group('3 Lists', () {
      late List<String> list1;
      late List<String> list2;
      late List<String> list3;

      setUpAll(() {
        list1 = ['A', 'B', 'C'];
        list2 = ['D', 'E', 'F'];
        list3 = ['G', 'H', 'I'];
      });

      test('3 Lists(0)', () {
        final List<String> res = Capsule.permutation(0, [list1, list2, list3]);
        expect(res, ['A', 'D', 'G']);
      });

      test('3 Lists(1)', () {
        final List<String> res = Capsule.permutation(1, [list1, list2, list3]);
        expect(res, ['B', 'D', 'G']);
      });

      test('3 Lists(2)', () {
        final List<String> res = Capsule.permutation(2, [list1, list2, list3]);
        expect(res, ['C', 'D', 'G']);
      });

      test('3 Lists(3)', () {
        final List<String> res = Capsule.permutation(3, [list1, list2, list3]);
        expect(res, ['A', 'E', 'G']);
      });

      test('3 Lists(4)', () {
        final List<String> res = Capsule.permutation(4, [list1, list2, list3]);
        expect(res, ['B', 'E', 'G']);
      });

      test('3 Lists(5)', () {
        final List<String> res = Capsule.permutation(5, [list1, list2, list3]);
        expect(res, ['C', 'E', 'G']);
      });

      test('3 Lists(6)', () {
        final List<String> res = Capsule.permutation(6, [list1, list2, list3]);
        expect(res, ['A', 'F', 'G']);
      });

      test('3 Lists(7)', () {
        final List<String> res = Capsule.permutation(7, [list1, list2, list3]);
        expect(res, ['B', 'F', 'G']);
      });

      test('3 Lists(8)', () {
        final List<String> res = Capsule.permutation(8, [list1, list2, list3]);
        expect(res, ['C', 'F', 'G']);
      });

      test('3 Lists(9)', () {
        final List<String> res = Capsule.permutation(9, [list1, list2, list3]);
        expect(res, ['A', 'D', 'H']);
      });

      test('3 Lists(10)', () {
        final List<String> res = Capsule.permutation(10, [list1, list2, list3]);
        expect(res, ['B', 'D', 'H']);
      });

      test('3 Lists(11)', () {
        final List<String> res = Capsule.permutation(11, [list1, list2, list3]);
        expect(res, ['C', 'D', 'H']);
      });

      test('3 Lists(12)', () {
        final List<String> res = Capsule.permutation(12, [list1, list2, list3]);
        expect(res, ['A', 'E', 'H']);
      });

      test('3 Lists(13)', () {
        final List<String> res = Capsule.permutation(13, [list1, list2, list3]);
        expect(res, ['B', 'E', 'H']);
      });

      test('3 Lists(14)', () {
        final List<String> res = Capsule.permutation(14, [list1, list2, list3]);
        expect(res, ['C', 'E', 'H']);
      });

      test('3 Lists(15)', () {
        final List<String> res = Capsule.permutation(15, [list1, list2, list3]);
        expect(res, ['A', 'F', 'H']);
      });

      test('3 Lists(16)', () {
        final List<String> res = Capsule.permutation(16, [list1, list2, list3]);
        expect(res, ['B', 'F', 'H']);
      });

      test('3 Lists(17)', () {
        final List<String> res = Capsule.permutation(17, [list1, list2, list3]);
        expect(res, ['C', 'F', 'H']);
      });

      test('3 Lists(18)', () {
        final List<String> res = Capsule.permutation(18, [list1, list2, list3]);
        expect(res, ['A', 'D', 'I']);
      });

      test('3 Lists(19)', () {
        final List<String> res = Capsule.permutation(19, [list1, list2, list3]);
        expect(res, ['B', 'D', 'I']);
      });

      test('3 Lists(20)', () {
        final List<String> res = Capsule.permutation(20, [list1, list2, list3]);
        expect(res, ['C', 'D', 'I']);
      });

      test('3 Lists(21)', () {
        final List<String> res = Capsule.permutation(21, [list1, list2, list3]);
        expect(res, ['A', 'E', 'I']);
      });

      test('3 Lists(22)', () {
        final List<String> res = Capsule.permutation(22, [list1, list2, list3]);
        expect(res, ['B', 'E', 'I']);
      });

      test('3 Lists(23)', () {
        final List<String> res = Capsule.permutation(23, [list1, list2, list3]);
        expect(res, ['C', 'E', 'I']);
      });

      test('3 Lists(24)', () {
        final List<String> res = Capsule.permutation(24, [list1, list2, list3]);
        expect(res, ['A', 'F', 'I']);
      });

      test('3 Lists(25)', () {
        final List<String> res = Capsule.permutation(25, [list1, list2, list3]);
        expect(res, ['B', 'F', 'I']);
      });

      test('3 Lists(26)', () {
        final List<String> res = Capsule.permutation(26, [list1, list2, list3]);
        expect(res, ['C', 'F', 'I']);
      });

      test('3 Lists(27)', () {
        final List<String> res = Capsule.permutation(27, [list1, list2, list3]);
        expect(res, ['A', 'D', 'G']);
      });
    });
  });
}
