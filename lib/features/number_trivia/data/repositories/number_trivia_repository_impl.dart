import 'package:dartz/dartz.dart';
import 'package:tdd_number_trivia/core/error/exception.dart';
import 'package:tdd_number_trivia/core/error/failures.dart';
import 'package:tdd_number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_number_trivia/features/number_trivia/domain/repositories_contracts/number_trivia_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';

// TODO change to non nullable after implementing
typedef Future<NumberTriviaModel>? _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // TODO change to non nullable after implementing
  @override
  Future<Either<Failure, NumberTrivia?>?>? getConcreteNumberTrivia(int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  // TODO change to non nullable after implementing
  @override
  Future<Either<Failure, NumberTrivia?>?>? getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  // TODO change to non nullable after implementing
  Future<Either<Failure, NumberTrivia?>?>? _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if ((await networkInfo.isConnected) ?? false) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}