// Mocks generated by Mockito 5.3.0 from annotations
// in tdd_number_trivia/test/features/number_trivia/data/datasources/number_trivia_local_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i2;
import 'package:tdd_number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i5;
import 'package:tdd_number_trivia/features/number_trivia/data/models/number_trivia_model.dart'
    as _i3;

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

class _FakeSharedPreferences_0 extends _i1.SmartFake
    implements _i2.SharedPreferences {
  _FakeSharedPreferences_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeNumberTriviaModel_1 extends _i1.SmartFake
    implements _i3.NumberTriviaModel {
  _FakeNumberTriviaModel_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreferences extends _i1.Mock implements _i2.SharedPreferences {
  @override
  Set<String> getKeys() => (super.noSuchMethod(Invocation.method(#getKeys, []),
      returnValue: <String>{},
      returnValueForMissingStub: <String>{}) as Set<String>);
  @override
  Object? get(String? key) =>
      (super.noSuchMethod(Invocation.method(#get, [key]),
          returnValueForMissingStub: null) as Object?);
  @override
  bool? getBool(String? key) =>
      (super.noSuchMethod(Invocation.method(#getBool, [key]),
          returnValueForMissingStub: null) as bool?);
  @override
  int? getInt(String? key) =>
      (super.noSuchMethod(Invocation.method(#getInt, [key]),
          returnValueForMissingStub: null) as int?);
  @override
  double? getDouble(String? key) =>
      (super.noSuchMethod(Invocation.method(#getDouble, [key]),
          returnValueForMissingStub: null) as double?);
  @override
  String? getString(String? key) =>
      (super.noSuchMethod(Invocation.method(#getString, [key]),
          returnValueForMissingStub: null) as String?);
  @override
  bool containsKey(String? key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false, returnValueForMissingStub: false) as bool);
  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(#getStringList, [key]),
          returnValueForMissingStub: null) as List<String>?);
  @override
  _i4.Future<bool> setBool(String? key, bool? value) =>
      (super.noSuchMethod(Invocation.method(#setBool, [key, value]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> setInt(String? key, int? value) =>
      (super.noSuchMethod(Invocation.method(#setInt, [key, value]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> setDouble(String? key, double? value) =>
      (super.noSuchMethod(Invocation.method(#setDouble, [key, value]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> setString(String? key, String? value) =>
      (super.noSuchMethod(Invocation.method(#setString, [key, value]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> setStringList(String? key, List<String>? value) =>
      (super.noSuchMethod(Invocation.method(#setStringList, [key, value]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> remove(String? key) =>
      (super.noSuchMethod(Invocation.method(#remove, [key]),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> commit() =>
      (super.noSuchMethod(Invocation.method(#commit, []),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
  @override
  _i4.Future<bool> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
          returnValue: _i4.Future<bool>.value(false),
          returnValueForMissingStub: _i4.Future<bool>.value(false))
      as _i4.Future<bool>);
  @override
  _i4.Future<void> reload() => (super.noSuchMethod(
      Invocation.method(#reload, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [NumberTriviaLocalDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaLocalDataSourceImpl extends _i1.Mock
    implements _i5.NumberTriviaLocalDataSourceImpl {
  MockNumberTriviaLocalDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SharedPreferences get sharedPreferences =>
      (super.noSuchMethod(Invocation.getter(#sharedPreferences),
              returnValue: _FakeSharedPreferences_0(
                  this, Invocation.getter(#sharedPreferences)))
          as _i2.SharedPreferences);
  @override
  _i4.Future<_i3.NumberTriviaModel> getLastNumberTrivia() =>
      (super.noSuchMethod(Invocation.method(#getLastNumberTrivia, []),
              returnValue: _i4.Future<_i3.NumberTriviaModel>.value(
                  _FakeNumberTriviaModel_1(
                      this, Invocation.method(#getLastNumberTrivia, []))))
          as _i4.Future<_i3.NumberTriviaModel>);
  @override
  _i4.Future<void> cacheNumberTrivia(_i3.NumberTriviaModel? triviaToCache) =>
      (super.noSuchMethod(
              Invocation.method(#cacheNumberTrivia, [triviaToCache]),
              returnValue: _i4.Future<void>.value(),
              returnValueForMissingStub: _i4.Future<void>.value())
          as _i4.Future<void>);
}
