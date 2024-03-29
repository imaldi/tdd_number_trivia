import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
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
    on<GetTriviaForConcreteNumber>((event, emit) async
    {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      emit(Loading());

      // var errorOrLoaded = await
      await inputEither.fold(
        (failure) async {
          emit(const Error(message: invalidInputFailureMessage));
        },
        // (integer) =>  Loaded(trivia: NumberTrivia(text: '', number: integer)),
        (integer) async {
          // getConcreteNumberTrivia(Params(number: integer));
          final failureOrNumberTrivia =
              await getConcreteNumberTrivia(Params(number: integer));

          var errOrLoad = failureOrNumberTrivia.fold((failure) {
            return Error(message: _mapFailureToMessage(failure));
            // throw UnimplementedError();
          }, (trivia) {
            return Loaded(trivia: trivia);
          });
          emit(errOrLoad);
          // return errOrLoad;
        },
      );
      // emit(errorOrLoaded);
    }
    );
    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());

      final failureOrNumberTrivia =
          await getRandomNumberTrivia(
        NoParams(),
      );

      var errOrLoad = failureOrNumberTrivia.fold((failure) {
        return Error(message: _mapFailureToMessage(failure));
      }, (trivia) {
        return Loaded(trivia: trivia);
      });

      emit(errOrLoad);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
