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

}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockMockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
        () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.

      // There was an error here, how to fix it below this file:
          // kita pastikan ketika method .getConcreteNumberTrivia mock nya terpanggil,
          // selalu return Tipe sebelah kanan dari Either yang di return method tersebut,
          // yaitu type/class NumberTrivia dengan value tNumberTrivia
          // Pertanyaannnya kenapa harus pakai Right dan ga langsung pakai NumberTrivia aja??
          // Masih belum terjawab (pasti soal FP ini)
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // The "act" phase of the test. Call the not-yet-existent method.
      // Disini bener2 kita panggil useCase nya (yang mana usecase tersebut manggil satu method repository contract),
      // kebetulan disini method yang sebelumnya namanya execute
      // udah di ganti namanya jadi call, dan dalam dart bisa panggil dengan cara ini (object())
      final result = await usecase(number: tNumber);
      // UseCase should simply return whatever was returned from the Repository
      // disini kita melakukan perbandingan antara result real dan result yang diharapkan
      // argumen pertama result real, argumen kedua result expected
      expect(result, Right(tNumberTrivia));
      // Verify that the method has been called on the Repository
      // kita pakai verify ini (dari library mockito) untuk memastikan bahwa method getConcreteNumberTrivia
      // di panggil dengan argumen tNumber (ini karena ketika di when kita pakai argumentMatcher "any"
      // sehingga ketika method getConcreteNumberTrivia dipanggil dengan argumen apapun, selalu me-return
      // value yang tetap (sesuai yang di beri di thenAnswer())
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      // Only the above method should be called and nothing more.
      // pastikan ga terpanggil / ga ada interaksi apapun lagi
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
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
