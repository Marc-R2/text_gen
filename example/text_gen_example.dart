import 'package:text_gen/text_gen.dart';

void main() {
  final textGenerator = GeneratedParser.parse('(The weather is {very really} nice today)');
  final text = textGenerator!.buildVariant();

  print(text);
}
