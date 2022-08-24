// Mocks generated by Mockito 5.3.0 from annotations
// in tdd_number_trivia/test/features/number_trivia/domain/use_cases/get_concrete_number_trivia_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tdd_number_trivia/core/error/failures.dart' as _i5;
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart'
    as _i6;

import 'get_concrete_number_trivia_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [MockNumberTriviaRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockNumberTriviaRepository extends _i1.Mock
    implements _i2.MockNumberTriviaRepository {
  MockMockNumberTriviaRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.NumberTrivia?>?>?
      getConcreteNumberTrivia(int? number) => (super.noSuchMethod(
              Invocation.method(#getConcreteNumberTrivia, [number]))
          as _i3.Future<_i4.Either<_i5.Failure, _i6.NumberTrivia?>?>?);
}
