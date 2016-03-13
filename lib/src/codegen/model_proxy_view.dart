// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/codegen.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';

import '../../view.dart';
import 'reflectable_annotation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates source code for the model [view] into the [buffer].
void generateModelProxy(ModelProxyView view, StringBuffer buffer) {
  generateClassDefinition(
      view.metadata,
      buffer,
      _generateModelDefinition(view)
  );
}

/// Creates a class generator for the given model [view].
ClassGenerator _generateModelDefinition(ModelProxyView view) =>
    (metadata, buffer) {
      var metadata = view.metadata;

      // Generate source code for the fields
      var fields = classMetadataQueryAll/*<FieldMetadata>*/(
          metadata,
          not(propertyFieldMatch),
          includeFields: true
      );

      generateFields(fields, buffer);

      // Generate source code for the properties
      var properties = classMetadataQueryAll/*<FieldMetadata>*/(
          metadata,
          propertyFieldMatch,
          includeFields: true
      );

      generateFields(
          properties,
          buffer,
          getterGenerator: _generateGetterDefinition,
          setterGenerator: _generateSetterDefinition,
          annotationGenerators: [
            generateOverrideAnnotation,
            generateReflectableAnnotation
          ]
      );
    };

void _generateGetterDefinition(FieldMetadata metadata, StringBuffer buffer) {
  buffer.write('_model.${metadata.name};');
}

void _generateSetterDefinition(FieldMetadata metadata, StringBuffer buffer) {
  buffer.writeln('_model.${metadata.name} = value;');
}
