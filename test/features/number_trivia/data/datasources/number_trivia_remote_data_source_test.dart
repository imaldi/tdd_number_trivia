import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_number_trivia/core/error/exception.dart';
import 'package:tdd_number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<http.Client>(),
])
import 'number_trivia_remote_data_source_test.mocks.dart';

main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('Something went wrong', 404),
    );
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;

    test(
        'should perform a GET request on an URL with number being the endpoint and with application/json header',
        () {
      /// arrange
      setUpMockHttpClientSuccess200();

      /// act
      dataSource.getConcreteNumberTrivia(tNumber);

      /// assert
      verify(mockHttpClient
          .get(Uri(path: 'http://numbersapi.com/$tNumber'), headers: {
        'Content-Type': 'application/json',
      }));

    });

    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should return NumberTrivia when the response code is 200 (success)', () async {
      /// arrange
      setUpMockHttpClientSuccess200();
      /// act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      /// assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      /// arrange
      setUpMockHttpClientFailure404();
      /// act
      final call = dataSource.getConcreteNumberTrivia;
      /// assert
      expect(() => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should preform a GET request on a URL with *random* endpoint with application/json header',
          () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRandomNumberTrivia();
        // assert
        verify(mockHttpClient.get(
          Uri(path: 'http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
