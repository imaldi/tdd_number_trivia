import 'package:dartz/dartz.dart';
import 'package:tdd_number_trivia/core/error/failures.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';


abstract class NumberTriviaRepository {
  // TODO change to non nullable after implementing
  Future<Either<Failure, NumberTrivia?>?>? getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia?>?>? getRandomNumberTrivia();
}