// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:polymer/src/common/reflectable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Instantiates instances of [PolymerReflectable] when analyzing source code.
final AnalyzeAnnotation analyzerReflectableAnnotation =
    analyzeAnnotation(
        'PolymerReflectable',
        library: 'polymer.src.common.reflectable'
    );
