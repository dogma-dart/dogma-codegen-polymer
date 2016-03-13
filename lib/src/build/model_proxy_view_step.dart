// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import '../../view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ModelProxyViewStep implements ViewStep {
  @override
  MetadataView<LibraryMetadata> view(LibraryMetadata metadata) =>
      new ModelProxyLibraryView(metadata);
}
