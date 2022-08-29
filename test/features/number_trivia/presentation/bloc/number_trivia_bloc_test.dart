import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_number_trivia/core/error/failures.dart';
import 'package:tdd_number_trivia/core/util/input_converter.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
  MockSpec<InputConverter>(),
])
import 'number_trivia_bloc_test.mocks.dart';

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    const tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
      // when(mockInputConverter.stringToUnsignedInteger(any).fold((l) => any, (r) => any))
      // .thenReturn(null);
    }

    void setUpMockGetConcreteTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteTriviaSuccess();
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));

        /// We await untilCalled() because the logic inside a Bloc is triggered through a Stream<Event>
        /// which is, of course, asynchronous itself. Had we not awaited until the stringToUnsignedInteger has been called,
        /// the verification would always fail, since we'd verify before the code had a chance to execute.
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test('should emit [Error] when the input is invalid', () async {
      /// arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      /// act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));

      /// We await untilCalled() because the logic inside a Bloc is triggered through a Stream<Event>
      /// which is, of course, asynchronous itself. Had we not awaited until the stringToUnsignedInteger has been called,
      /// the verification would always fail, since we'd verify before the code had a chance to execute.
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      /// assert
      const expected = Error(message: invalidInputFailureMessage);
      expect(bloc.state, expected);
    });

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteTriviaSuccess();
        // when(mockInputConverter.stringToUnsignedInteger(any))
        //     .thenReturn(Right(tNumberParsed));
        // when(mockGetConcreteNumberTrivia.call(any))
        //     .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia.call(any));
        // assert
        verify(mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // when(mockInputConverter.stringToUnsignedInteger(any).fold<Event>).thenReturn((ifLeft, ifRight) => Loaded(trivia: tNumberTrivia));

        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        // assert later
        // final expected = [
        //   Empty(),
        //   Loading(),
        //   Loaded(trivia: tNumberTrivia),
        // ];
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // await untilCalled(mockInputConverter.stringToUnsignedInteger(any).fold);

        expect(bloc.state, Loading());
        await untilCalled(mockGetConcreteNumberTrivia.call(any));
        expect(bloc.state, Loaded(trivia: tNumberTrivia));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        // final expected = [
        //   Empty(),
        //   Loading(),
        //   Error(message: SERVER_FAILURE_MESSAGE),
        // ];
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        expect(bloc.state, Loading());

        await untilCalled(mockGetConcreteNumberTrivia.call(any));
        expect(bloc.state, const Error(message: serverFailureMessage));
      },
    );
  });
}
