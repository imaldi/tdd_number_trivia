import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_concrete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {
    // ignore: void_checks
    on<GetTriviaForConcreteNumber>((event, emit) async {

      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);



      // var errorOrLoaded = await
      inputEither.fold(
        (failure) async {

          emit(const Error(message: invalidInputFailureMessage));
          return const Error(message: invalidInputFailureMessage);
          },
        // (integer) =>  Loaded(trivia: NumberTrivia(text: '', number: integer)),
        (integer) async {
          // getConcreteNumberTrivia(Params(number: integer));
          final failureOrNumberTrivia = await getConcreteNumberTrivia(Params(number: integer));

          var errOrLoad = failureOrNumberTrivia.fold((l) {
            emit(const Error(message: "No Trivia"));
            return const Error(message: "No Trivia");
          }, (r) {
            emit(Loaded(trivia: r));
            return Loaded(trivia: r);
          });
          emit(errOrLoad);
          return errOrLoad;

          // return
          //   Loaded(trivia: const NumberTrivia(text: "default", number: 1));
          // return Loaded(trivia: failureOrNumberTrivia);
          // return failureOrNumberTrivia;
        },
      );
      // emit(errorOrLoaded);

    });
  }
}
