/// Support for doing something awesome.
///
/// More dartdocs go here.
library text_gen;

import 'dart:math' as math;

import 'package:uuid/uuid.dart';

part 'src/gen.dart';

part 'src/editable/capsule.dart';
part 'src/editable/parser.dart';
part 'src/editable/random.dart';
part 'src/editable/txt.dart';

part 'src/static/capsule.dart';
part 'src/static/random.dart';
part 'src/static/txt.dart';

final random = math.Random();
