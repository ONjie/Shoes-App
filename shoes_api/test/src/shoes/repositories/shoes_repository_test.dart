import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/redis_cache_service.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

const redisCacheError = 'such key does not exist';


class MockRedisCacheService extends Mock implements RedisCacheService {}

void main() {
  late MockRedisCacheService mockRedisCacheService;
  late ShoesRepositoryImpl shoesRepositoryImpl;

  setUp(() {
    mockRedisCacheService = MockRedisCacheService();
    shoesRepositoryImpl = ShoesRepositoryImpl(
      redisService: mockRedisCacheService,
    );
  });

  const tShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image'],
    price: 100,
    brand: 'brand',
    colors: ['color'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: true,
    category: 'category',
    ratings: 1.5,
  );

  const tLatestShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image'],
    price: 100,
    brand: 'brand',
    colors: ['color'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'category',
    ratings: 1.5,
  );

  const tPopular = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image'],
    price: 100,
    brand: 'brand',
    colors: ['color'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: false,
    category: 'category',
    ratings: 1.5,
  );

  const tOtherShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image'],
    price: 100,
    brand: 'brand',
    colors: ['color'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: false,
    category: 'category',
    ratings: 1.5,
  );

  const tBrand = 'brand';

  group('fetchLatestShoes', () {
    test('should return a list of latest shoes when call is successful',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchLatestShoes())
          .thenAnswer((_) async => [tLatestShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tLatestShoe]));
      verify(() => mockRedisCacheService.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test('should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchLatestShoes())
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(() => mockRedisCacheService.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchLatestShoes())
          .thenThrow(OtherException(message: fetchLatestShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchLatestShoesErrorMessage)),
      );
      verify(() => mockRedisCacheService.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchLatestShoesbyBrand', () {
    test(
        'should return a list of latest shoes by brand when call is successful',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenAnswer((_) async => [tLatestShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tLatestShoe]));
      verify(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result =
          await shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(OtherException(message: fetchLatestShoesByBrandErrorMessage));
      // act
      final result =
          await shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(
          const OtherFailure(message: fetchLatestShoesByBrandErrorMessage),
        ),
      );
      verify(
        () => mockRedisCacheService.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

 group('fetchOtherShoes', () {
    test(
        'should return a list of other shoes when call is successful',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchOtherShoes())
          .thenAnswer((_) async => [tOtherShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tOtherShoe]));
      verify(() => mockRedisCacheService.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchOtherShoes())
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(() => mockRedisCacheService.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchOtherShoes())
          .thenThrow(OtherException(message: fetchOtherShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchOtherShoesErrorMessage)),
      );
      verify(() => mockRedisCacheService.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchOtherShoesbyBrand', () {
    test(
        'should return a list of other shoes by brand when call is successful',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenAnswer((_) async => [tOtherShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tOtherShoe]));
      verify(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result =
          await shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(OtherException(message: fetchOtherShoesByBrandErrorMessage));
      // act
      final result =
          await shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchOtherShoesByBrandErrorMessage)),
      );
      verify(
        () => mockRedisCacheService.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchPopularShoes', () {
    test(
        'should return a list of popular shoes when call is successful',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchPopularShoes())
          .thenAnswer((_) async => [tPopular]);

      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tPopular]));
      verify(() => mockRedisCacheService.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchPopularShoes())
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(() => mockRedisCacheService.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchPopularShoes())
          .thenThrow(OtherException(message: fetchPopularShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchPopularShoesErrorMessage)),
      );
      verify(() => mockRedisCacheService.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchPopularShoesbyBrand', () {
    test(
        'should return a list of popular shoes by brand when call is successful',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenAnswer((_) async => [tPopular]);

      // act
      final result =
          await shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tPopular]));
      verify(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result =
          await shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(
        OtherException(message: fetchPopularShoesByBrandErrorMessage),
      );
      // act
      final result =
          await shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(
          const OtherFailure(message: fetchPopularShoesByBrandErrorMessage),
        ),
      );
      verify(
        () => mockRedisCacheService.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchShoeById', () {
    test('should return a shoe when call is successful',
        () async {
      // arrange
      when(() =>
              mockRedisCacheService.fetchShoeById(id: any(named: 'id')),)
          .thenAnswer((_) async => tShoe);

      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Right<Failure, Shoe>>());
      expect(result.right, equals(tShoe));
      verify(() =>
              mockRedisCacheService.fetchShoeById(id: any(named: 'id')),)
          .called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() =>
              mockRedisCacheService.fetchShoeById(id: any(named: 'id')),)
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Left<Failure, Shoe>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(() =>
              mockRedisCacheService.fetchShoeById(id: any(named: 'id')),)
          .called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchShoes', () {
    test(
        'should return a list of shoes when call is successful',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchShoes())
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(() => mockRedisCacheService.fetchShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchShoes())
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(() => mockRedisCacheService.fetchShoes()).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchShoesByBrand', () {
    test(
        'should return a list of shoes by brand when call is successful',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchShoesByBrand(
          brand: any(named: 'brand'),),).thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        () => mockRedisCacheService.fetchShoesByBrand(
            brand: any(named: 'brand'),),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchShoesByBrand(
              brand: any(named: 'brand'),),)
          .thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesByBrand(
            brand: any(named: 'brand'),),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(() => mockRedisCacheService.fetchShoesByBrand(
              brand: any(named: 'brand'),),)
          .thenThrow(OtherException(message: fetchShoesByBrandErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesByBrandErrorMessage)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesByBrand(
            brand: any(named: 'brand'),),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchShoesByCategoryAndBrand', () {
    const tCategory = 'category';
    test(
        'should return a list of shoes by category when call is successful',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
        category: tCategory,
        brand: tBrand,
      );

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
        category: tCategory,
        brand: tBrand,
      );

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).thenThrow(OtherException(message: fetchShoesByCategoryErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
        category: tCategory,
        brand: tBrand,
      );

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesByCategoryErrorMessage)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

  group('fetchShoesSuggestions', () {
    test(
        'should return a list of shoes by suggestion when call is successful',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).thenAnswer((_) async => [tShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a RedisCacheFailure when RedisCacheException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).thenThrow(RedisCacheException(message: redisCacheError));
      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const RedisCacheFailure(message: redisCacheError)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });

    test(
        'should return a OtherFailure when OtherException is thrown',
        () async {
      // arrange
      when(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).thenThrow(
        OtherException(message: fetchShoesSuggestionsErrorMessage),
      );
      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesSuggestionsErrorMessage)),
      );
      verify(
        () => mockRedisCacheService.fetchShoesSuggestions(
          title: any(named: 'title'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRedisCacheService);
    });
  });

}
