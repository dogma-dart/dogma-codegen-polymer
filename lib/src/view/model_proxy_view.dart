// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [ClassMetadata] for model data.
class ModelProxyView extends MetadataView<ClassMetadata> {
  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates and instance of [ModelProxyView] from the [metadata].
  ///
  /// This constructor assumes that the [metadata] is a valid model. It does
  /// not do any verification.
  factory ModelProxyView(ClassMetadata metadata) {
    return new ModelProxyView._(metadata);
  }

  /// Creates an instance of [ModelProxyView] from the [metadata].
  ModelProxyView._(ClassMetadata metadata)
      : super(metadata);
}
