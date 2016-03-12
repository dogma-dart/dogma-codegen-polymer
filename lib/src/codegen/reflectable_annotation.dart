// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/src/common/reflectable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates the @reflectable annotation into the [buffer] if the [value] is
/// equal to [reflectable].
void generateReflectableAnnotation(dynamic value, StringBuffer buffer) {
  if (value == reflectable) {
    buffer.writeln('@reflectable');
  }
}
