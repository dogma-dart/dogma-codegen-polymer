// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/view.dart';
import 'package:dogma_codegen_model/view.dart';
import 'package:polymer/src/common/reflectable.dart';

import '../../view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class ModelProxyViewGenerationStep implements ViewGenerationStep {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The type a model proxy descends from.
  static final TypeMetadata supertype = new TypeMetadata('JsProxy');
  /// The name of the model field.
  static const String modelFieldName = '_model';

  //---------------------------------------------------------------------
  // ViewGenerationStep
  //---------------------------------------------------------------------

  @override
  MetadataView<LibraryMetadata> viewGeneration(MetadataView<LibraryMetadata> source) {
    var modelView = source as ModelLibraryView;

    // Generate the proxies
    var classes = <ClassMetadata>[];

    for (var model in modelView.models) {
      classes.add(_generateModelProxy(model, <String>[]));
    }

    // Create the library
    var library = new LibraryMetadata(
        Uri.parse('package:output/test.dart'),
        classes: classes
    );

    return new ModelProxyLibraryView(library);
  }

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Gets the default name for a proxy with the given [modelType].
  static String defaultProxyName(String modelType) => '${modelType}Proxy';

  /// Generates a model proxy from the given [model].
  static ClassMetadata _generateModelProxy(ModelClassView model, List<String> ignore) {
    var metadata = model.metadata;
    var metadataType = metadata.type;
    var metadataName = metadata.name;

    // Get the instance fields on the class
    var fields = classMetadataQueryAll/*<FieldMetadata>*/(
        metadata,
        instanceMatch,
        includeFields: true
    ) as Iterable<FieldMetadata>;

    // Create the model field
    var proxyFields = <FieldMetadata>[
      new FieldMetadata.field(
          modelFieldName,
          metadataType,
          isPrivate: true,
          isFinal: true
      )
    ];

    // Create the wrapper fields
    for (var field in fields) {
      var fieldName = field.name;
      var annotations = [override];

      // Determine if the field is reflectable
      if (!ignore.contains(fieldName)) {
        annotations.add(reflectable);
      }

      proxyFields.add(new FieldMetadata(
          fieldName,
          field.type,
          true,          // Its a property
          field.getter,  // Getter
          field.setter,  // Setter
          annotations: annotations
      ));
    }

    // Create a constructor that takes an instance of the type
    var proxyClassName = defaultProxyName(metadataName);

    var defaultConstructor = new ConstructorMetadata(
        new TypeMetadata(proxyClassName),
        parameters: [new ParameterMetadata(modelFieldName, metadataType)]
    );

    // Get the instance methods on the class
    var methods = classMetadataQueryAll/*<MethodMetadata>*/(
        metadata,
        instanceMatch,
        includeMethods: true
    ).toList();

    // Create the class instance
    return new ClassMetadata(
        proxyClassName,              // Add Proxy to the name
        supertype: supertype,        // Needs to extend from JsProxy
        interfaces: [metadata.type], // Needs to implement the passed in class
        fields: proxyFields,
        constructors: [defaultConstructor],
        methods: methods,
        comments: 'A proxy for [$metadataName] which can be used within Polymer.'
    );
  }
}
