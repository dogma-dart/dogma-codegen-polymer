// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';
import 'package:polymer/src/common/reflectable.dart';

import 'package:dogma_codegen_polymer/codegen.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('No generation', () {
    var buffer = new StringBuffer();
    generateReflectableAnnotation(1, buffer);
    expect(buffer, isEmpty);
  });
  test('Generation', () {
    var buffer = new StringBuffer();
    generateReflectableAnnotation(reflectable, buffer);
    expect(buffer.toString(), equalsIgnoringWhitespace('@reflectable'));
  });
}
