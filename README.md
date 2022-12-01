# TextGen

[![Dart](https://github.com/Marc-R2/text_gen/actions/workflows/dart.yml/badge.svg)](https://github.com/Marc-R2/text_gen/actions/workflows/dart.yml)
[![codecov](https://codecov.io/gh/Marc-R2/text_gen/branch/master/graph/badge.svg?token=KDCBH47FDA)](https://codecov.io/gh/Marc-R2/text_gen)

Generates text variations based on simple rules.


## Quick Start
    final textGenerator = GeneratedParser.parse('(The weather is {very really} nice today)');
    final text = textGenerator!.buildVariant();


## Getting Started

The use is as simple as it is easy.
All you need to start with is a sentence or a phrase.

Let's take for example: _**The weather is very nice today**_

This sentence could actually be used like this now, even though the variation in it is rather small so far. \
To be exact, there is exactly one variation yet: _**The weather is very nice today**_

### Variation

To bring variation into the text, curly brackets are used in the text.\
In this example, the word _**very**_ could be varied quite well.

_**The weather is {very really} nice today**_

### Parse

This string can now be understood by the parser in such a way that there is one sentence with _**very**_ and one with _**really**_ at the corresponding position.\
In the code this could look like this:

```dart
final textGenerator = GeneratedParser.parse('The weather is {very really} nice today');
```

### Generate

With this, these variants can now be generated lazily.\
The variants are completely reproducible. I.e. with the same index you always get the same text.
```dart
String variant1 = textGenerator.buildVariant(0);    // The weather is very nice today
String variant2 = textGenerator.buildVariant(1);    // The weather is really nice today
```

### Generate Randomly
This method can also randomly generate one of all possible variants on its own. \
To do this, simply omit the index.
```dart
String randomVariant = textGenerator.buildVariant();    // The weather is really nice today
String randomVariant = textGenerator.buildVariant();    // The weather is very nice today
String randomVariant = textGenerator.buildVariant();    // The weather is very nice today
//...
```

### Linked text
If the variation should consist of more than a single word, the text can be linked with round brackets, so that this is seen as a contiguous text.

_**(The weather is {(very nice) (so lovely)} today)**_

### Summary
There are no limits to creativity and complexity. These three simple building blocks (text, variation, link) can be nested arbitrarily and used to build large text models.\
So there can be a variation in a variation, which is part of a link, which in turn is part of a variation. And so on...

