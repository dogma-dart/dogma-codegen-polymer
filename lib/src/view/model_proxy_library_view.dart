// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_codegen_model/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';

import 'model_proxy_view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [LibraryMetadata] for model proxy data.
class ModelProxyLibraryView extends MetadataView<LibraryMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final List<ModelProxyView> models;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates and instance of [ModelLibraryView] from the [metadata].
  factory ModelProxyLibraryView(LibraryMetadata metadata) {
    var models = libraryMetadataQueryAll/*<ClassMetadata>*/(
        metadata,
        (_) => true,
        includeClasses: true
    ).map/*<ModelProxyView>*/((clazz) => new ModelProxyView(clazz)).toList();

    return new ModelProxyLibraryView._(metadata, models);
  }

  /// Creates an instance of [ModelProxyLibraryView] from the [metadata].
  ModelProxyLibraryView._(LibraryMetadata metadata, this.models)
      : super(metadata);
}
