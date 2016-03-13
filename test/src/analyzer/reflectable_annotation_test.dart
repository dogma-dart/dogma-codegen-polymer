// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:polymer/src/common/reflectable.dart';
import 'package:test/test.dart';

import 'package:dogma_codegen_polymer/analyzer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  var context = analysisContext();

  test('reflectable tests', () {
    var library = libraryMetadata(
        join('test/lib/reflectable_annotation.dart'),
        context,
        annotationCreators: [analyzerReflectableAnnotation]
    );

    var clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('A'),
        includeClasses: true
    ) as ClassMetadata;

    expect(clazz, isNotNull);
    expect(clazz.name, 'A');
    expect(clazz.fields, hasLength(2));

    var reflectableField = classMetadataQuery/*<FieldMetadata>*/(
        clazz,
        nameMatch('reflectableField'),
        includeFields: true
    ) as FieldMetadata;

    expect(reflectableField, isNotNull);
    expect(reflectableField.annotations, hasLength(1));

    var annotation = reflectableField.annotations[0];

    expect(annotation is PolymerReflectable, isTrue);
    expect(annotation, reflectable);

    var notReflectableField = classMetadataQuery/*<FieldMetadata>*/(
        clazz,
        nameMatch('notReflectableField'),
        includeFields: true
    ) as FieldMetadata;

    expect(notReflectableField, isNotNull);
    expect(notReflectableField.annotations, isEmpty);
  });
}
