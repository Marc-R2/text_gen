import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void parseAndReparse(String input, EditableGen expected) {
  final parsed = GeneratedParser.parse(input);
  expect(parsed, equals(expected));

  final rebuild = parsed?.buildArguments() ?? '';
  final reParsed = GeneratedParser.parse(rebuild);
  expect(reParsed, equals(expected));
  expect(reParsed.toString(), equals(expected.toString()));
  expect(reParsed.hashCode, equals(expected.hashCode));
}

void main() {
  group('GeneratedParser', () {
    test('should parse simple text', () {
      const input = 'Hello';
      final expected =
          EditableCapsule(encapsulated: [EditableTxt(text: input)]);
      parseAndReparse(input, expected);
    });

    test('should parse encapsulated text', () {
      const input = '(Hello, world!)';
      final expected = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'Hello,'),
          EditableTxt(text: 'world!')
        ],
      );
      parseAndReparse(input, expected);
    });

    test('should parse nested encapsulated text', () {
      const input = '(Hello, (beautiful) world!)';
      final expected = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'Hello,'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'beautiful')]),
          EditableTxt(text: 'world!'),
        ],
      );
      parseAndReparse(input, expected);
    });

    test('should parse text borderless to encapsulated', () {
      const input = 'close(Hello, world!)';
      final expected = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'close'),
          EditableCapsule(
            encapsulated: [
              EditableTxt(text: 'Hello,'),
              EditableTxt(text: 'world!'),
            ],
          ),
        ],
      );
      parseAndReparse(input, expected);
    });

    test('should parse text borderless to random', () {
      const input = '{Hello Hi}, close{world universe}!';
      final expected = EditableCapsule(
        encapsulated: [
          EditableRandom(
            possibilities: [
              EditableTxt(text: 'Hello'),
              EditableTxt(text: 'Hi'),
            ],
          ),
          EditableTxt(text: ','),
          EditableTxt(text: 'close'),
          EditableRandom(
            possibilities: [
              EditableTxt(text: 'world'),
              EditableTxt(text: 'universe'),
            ],
          ),
          EditableTxt(text: '!'),
        ],
      );
      parseAndReparse(input, expected);
    });
  });
}
