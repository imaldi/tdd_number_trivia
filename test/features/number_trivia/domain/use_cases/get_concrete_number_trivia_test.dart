import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/repositories_contracts/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([MockNumberTriviaRepository])
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {
  void main() {
    late GetConcreteNumberTrivia usecase;
    late MockMockNumberTriviaRepository mockNumberTriviaRepository;

    setUp() {
      mockNumberTriviaRepository = MockMockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    }

    final tNumber = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    test(
      'should get trivia for the number from the repository',
      () async {
        // "On the fly" implementation of the Repository using the Mockito package.
        // When getConcreteNumberTrivia is called with any argument, always answer with
        // the Right "side" of Either containing a test NumberTrivia object.

        // There was an error here, how to fix it below this file:
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // The "act" phase of the test. Call the not-yet-existent method.
        final result = await usecase.execute(number: tNumber);
        // UseCase should simply return whatever was returned from the Repository
        expect(result, Right(tNumberTrivia));
        // Verify that the method has been called on the Repository
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
        // Only the above method should be called and nothing more.
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );
  }
}

//
// That’s because of null-safety: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
//
// There are several steps to fix it:
//
// 1. in pubspec.yaml in dev_dependencies section add:
// build_runner: ^2.1.1
//
// 2. in get_concrete_number_trivia_test.dart add:
// import ‘package:mockito/annotations.dart’;
//
// and just before the main function add the annotation:
// @GenerateMocks([MockNumberTriviaRepository])
//
// 3. then run:
// flutter pub run build_runner build
// to generate the new mock class based on MockNumberTriviaRepository.
// By default a generated class name will be MockMockNumberTriviaRepository and its file name will be get_concrete_number_trivia_test.mocks.dart
//
// 4. so add import:
// import ‘get_concrete_number_trivia_test.mocks.dart’;
// and in main function change type MockNumberTriviaRepository to MockMockNumberTriviaRepository
