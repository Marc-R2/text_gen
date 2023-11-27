import 'package:test/test.dart';

import 'editable/capsule_test.dart' as capsule;
import 'editable/parser_test.dart' as parser;
import 'editable/random_test.dart' as random;
import 'editable/text_gen_test.dart' as text_gen;
import 'editable/txt_test.dart' as txt;
import 'static//txt_test.dart' as static_txt;
import 'static/capsule_test.dart' as static_capsule;
import 'static/random_test.dart' as static_random;

void main() {
  group('static', () {
    static_txt.main();
    static_capsule.main();
    static_random.main();
  });
  group('editable', () {
    text_gen.main();
    txt.main();
    capsule.main();
    random.main();
    parser.main();
  });
}
