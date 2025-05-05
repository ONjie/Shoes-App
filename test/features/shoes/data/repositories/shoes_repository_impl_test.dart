import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/shoes/data/data_sources/remote_data/shoes_api_service.dart';
import 'package:shoes_app/features/shoes/data/models/shoe_model.dart';
import 'package:shoes_app/features/shoes/data/repositories/shoes_repository_impl.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockShoesApiService extends Mock implements ShoesApiService {}

const notFoundMessage = 'Not Found';

void main() {
  late ShoesRepositoryImpl shoesRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockShoesApiService mockShoesApiService;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockShoesApiService = MockShoesApiService();

    shoesRepositoryImpl = ShoesRepositoryImpl(
      networkInfo: mockNetworkInfo,
      shoesApiService: mockShoesApiService,
    );
  });

  void runOnlineTest(Function body) {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOfflineTest(Function body) {
    group('when device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  const tShoeModel = ShoeModel(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: true,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tPopularShoe = ShoeModel(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: false,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tLatestShoe = ShoeModel(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tOtherShoe = ShoeModel(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: false,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tBrand = 'brand';

  group('fetchLatestShoes', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchLatestShoes();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchLatestShoes();

          //assert
          expect(
            result,
            equals(
              const Left(
                InternetConnectionFailure(message: noInternetConnectionMessage),
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchLatestShoes(),
          ).thenAnswer((_) async => [tLatestShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchLatestShoes();

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tLatestShoe.toShoeEntity()]));
          verify(() => mockShoesApiService.fetchLatestShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchLatestShoes(),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchLatestShoes();

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(() => mockShoesApiService.fetchLatestShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchLatestShoesByBrand', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchLatestShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(
            result,
            equals(
              const Left(
                InternetConnectionFailure(message: noInternetConnectionMessage),
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchLatestShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenAnswer((_) async => [tLatestShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchLatestShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tLatestShoe.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchLatestShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchLatestShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchLatestShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchLatestShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

    });
  });

  group('fetchOtherShoes', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchOtherShoes();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchOtherShoes();

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchOtherShoes(),
          ).thenAnswer((_) async => [tOtherShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchOtherShoes();

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tOtherShoe.toShoeEntity()]));
          verify(() => mockShoesApiService.fetchOtherShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchOtherShoes(),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchOtherShoes();

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(() => mockShoesApiService.fetchOtherShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchOtherShoesByBrand', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchOtherShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchOtherShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenAnswer((_) async => [tOtherShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchOtherShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tOtherShoe.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchOtherShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchOtherShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchOtherShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchOtherShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchPopularShoes', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchPopularShoes();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchPopularShoes();

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchPopularShoes(),
          ).thenAnswer((_) async => [tPopularShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchPopularShoes();

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tPopularShoe.toShoeEntity()]));
          verify(() => mockShoesApiService.fetchPopularShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchPopularShoes(),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchPopularShoes();

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(() => mockShoesApiService.fetchPopularShoes()).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchPopularShoesByBrand', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchPopularShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchPopularShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenAnswer((_) async => [tPopularShoe]);

          //act
          final result = await shoesRepositoryImpl.fetchPopularShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tPopularShoe.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchPopularShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchPopularShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchPopularShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchPopularShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchShoe', () {
    const tShoeId = 1;
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchShoe(shoeId: tShoeId);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchShoe(shoeId: tShoeId);

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(ShoeEntity) when call is successful', () async {
        //arrange
        when(
          () => mockShoesApiService.fetchShoe(shoeId: any(named: 'shoeId')),
        ).thenAnswer((_) async => tShoeModel);

        //act
        final result = await shoesRepositoryImpl.fetchShoe(shoeId: tShoeId);

        //assert
        expect(result, equals(isA<Right<Failure, ShoeEntity>>()));
        expect(result.right, equals(tShoeModel.toShoeEntity()));
        verify(
          () => mockShoesApiService.fetchShoe(shoeId: any(named: 'shoeId')),
        ).called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockShoesApiService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoe(shoeId: any(named: 'shoeId')),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchShoe(shoeId: tShoeId);

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchShoe(shoeId: any(named: 'shoeId')),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchShoesByBrand', () {
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenAnswer((_) async => [tShoeModel]);

          //act
          final result = await shoesRepositoryImpl.fetchShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tShoeModel.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchShoesByBrand(
            brand: tBrand,
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchShoesByBrand(
              brand: any(named: 'brand'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

    });
  });

  group('fetchShoesByCategory', () {
    const tCategory = 'category';
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchShoesByCategory(category: tCategory, brand: tBrand);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchShoesByCategory(
            category: tCategory,
            brand: tBrand
          );
          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesByCategory(
              category: any(named: 'category'),
              brand: any(named: 'brand')
            ),
          ).thenAnswer((_) async => [tShoeModel]);

          //act
          final result = await shoesRepositoryImpl.fetchShoesByCategory(
            category: tCategory,
            brand: tBrand
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tShoeModel.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchShoesByCategory(
              category: any(named: 'category'),
              brand: any(named: 'brand')
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesByCategory(
              category: any(named: 'category'),
              brand: any(named: 'brand')
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchShoesByCategory(
            category: tCategory,
            brand: tBrand
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchShoesByCategory(
              category: any(named: 'category'),
              brand: any(named: 'brand')
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('fetchShoesSuggestions', () {
    const tShoeTitle = 'title';
    test('checks if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      shoesRepositoryImpl.fetchShoesSuggestions(shoeTitle: tShoeTitle);

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return InternetConnectionFailure when device is offline',
        () async {
          //act
          final result = await shoesRepositoryImpl.fetchShoesSuggestions(
            shoeTitle: tShoeTitle,
          );
          //assert
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(List<ShoeEntity>) when call is successful',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesSuggestions(
              shoeTitle: any(named: 'shoeTitle'),
            ),
          ).thenAnswer((_) async => [tShoeModel]);

          //act
          final result = await shoesRepositoryImpl.fetchShoesSuggestions(
            shoeTitle: tShoeTitle,
          );

          //assert
          expect(result, equals(isA<Right<Failure, List<ShoeEntity>>>()));
          expect(result.right, equals([tShoeModel.toShoeEntity()]));
          verify(
            () => mockShoesApiService.fetchShoesSuggestions(
              shoeTitle: any(named: 'shoeTitle'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return ServerFailure when ServerException is thrown',
        () async {
          //arrange
          when(
            () => mockShoesApiService.fetchShoesSuggestions(
              shoeTitle: any(named: 'shoeTitle'),
            ),
          ).thenThrow(ServerException(message: notFoundMessage));

          //act
          final result = await shoesRepositoryImpl.fetchShoesSuggestions(
            shoeTitle: tShoeTitle,
          );

          //assert
          expect(result.left, equals(ServerFailure(message: notFoundMessage)));
          verify(
            () => mockShoesApiService.fetchShoesSuggestions(
              shoeTitle: any(named: 'shoeTitle'),
            ),
          ).called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockShoesApiService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

    });
  });
}
