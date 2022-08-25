import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_number_trivia/core/error/exception.dart';
import 'package:tdd_number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
])
import 'number_trivia_local_data_source_test.mocks.dart';


void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    // cacheException = MockCacheException();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  
  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    
    test('should return NumberTrivia from SharedPreferences when there is one in the cache', () async {
      /// arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));
      /// act
      final result = await dataSource.getLastNumberTrivia();
      /// assert
      verify(mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cached value',(){
      /// arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      /// act
      /// Not calling the method here, just storing it inside a call variable
      final call = dataSource.getLastNumberTrivia;
      /// assert
      /// calling the method happens from a higher-order function passed.
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test trivia');
    
    test('should call SharedPreferences to cache the data', () {
      /// act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      /// assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(cachedNumberTrivia, expectedJsonString));
    });
  });
}