import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_number_trivia/core/usecases/usecase.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/repositories_contracts/number_trivia_repository.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';

import 'get_random_number_trivia_test.mocks.dart';


@GenerateMocks([MockNumberTriviaRepository])
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockMockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia from the repository',
        () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      // Since random number doesn't require any parameters, we pass in NoParams.
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}