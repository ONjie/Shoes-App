import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/supabase_database.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

class MockSupabaseDatabase extends Mock implements SupabaseDatabase {}

void main() {
  late MockSupabaseDatabase supabaseDatabase;
  late ShoesRepositoryImpl shoesRepositoryImpl;

  setUp(() {
    supabaseDatabase = MockSupabaseDatabase();
    shoesRepositoryImpl =
        ShoesRepositoryImpl(supabaseDatabase: supabaseDatabase);
  });

  const tShoe = Shoe(
    id: 1,
    title: 'Title',
    description: 'Description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: true,
    category: 'Men',
    ratings: 1.5,
  );

  const tLatestShoe = Shoe(
    id: 1,
    title: 'Title',
    description: 'Description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'category',
    ratings: 1.5,
  );

  const tPopular = Shoe(
    id: 1,
    title: 'Title',
    description: 'Description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: false,
    category: 'category',
    ratings: 1.5,
  );

  const tOtherShoe = Shoe(
    id: 1,
    title: 'Title',
    description: 'Description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: false,
    category: 'category',
    ratings: 1.5,
  );

  const tBrand = 'brand';

  group('fetchLatestShoes', () {
    test(
        'should return a list of latest shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchLatestShoes())
          .thenAnswer((_) async => [tLatestShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tLatestShoe]));
      verify(() => supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchLatestShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchLatestShoes())
          .thenThrow(OtherException(message: fetchLatestShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchLatestShoesErrorMessage)),
      );
      verify(() => supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchLatestShoesbyBrand', () {
    test(
        'should return a list of latest shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchLatestShoesByBrand(
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
        () => supabaseDatabase.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result =
          await shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(
        () => supabaseDatabase.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchLatestShoesByBrand(
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
        () => supabaseDatabase.fetchLatestShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchOtherShoes', () {
    test(
        'should return a list of other shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchOtherShoes())
          .thenAnswer((_) async => [tOtherShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tOtherShoe]));
      verify(() => supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchOtherShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchOtherShoes())
          .thenThrow(OtherException(message: fetchOtherShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchOtherShoesErrorMessage)),
      );
      verify(() => supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchOtherShoesbyBrand', () {
    test(
        'should return a list of other shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchOtherShoesByBrand(
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
        () => supabaseDatabase.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result =
          await shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(
        () => supabaseDatabase.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchOtherShoesByBrand(
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
        () => supabaseDatabase.fetchOtherShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchPopularShoes', () {
    test(
        'should return a list of popular shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchPopularShoes())
          .thenAnswer((_) async => [tPopular]);

      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tPopular]));
      verify(() => supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchPopularShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchPopularShoes())
          .thenThrow(OtherException(message: fetchPopularShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchPopularShoesErrorMessage)),
      );
      verify(() => supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchPopularShoesbyBrand', () {
    test(
        'should return a list of popular shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchPopularShoesByBrand(
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
        () => supabaseDatabase.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result =
          await shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(
        () => supabaseDatabase.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        () => supabaseDatabase.fetchPopularShoesByBrand(
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
        () => supabaseDatabase.fetchPopularShoesByBrand(
          brand: any(named: 'brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoeById', () {
    test('should return a shoe when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoeById(id: any(named: 'id')))
          .thenAnswer((_) async => tShoe);

      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Right<Failure, Shoe>>());
      expect(result.right, equals(tShoe));
      verify(() => supabaseDatabase.fetchShoeById(id: any(named: 'id')))
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoeById(id: any(named: 'id')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Left<Failure, Shoe>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchShoeById(id: any(named: 'id')))
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoes', () {
    test(
        'should return a list of shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoes())
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(() => supabaseDatabase.fetchShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoesByBrand', () {
    test(
        'should return a list of shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')))
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(() =>
              supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')),)
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() =>
              supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')),)
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')))
          .thenThrow(OtherException(message: fetchShoesByBrandErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesByBrandErrorMessage)),
      );
      verify(() =>
              supabaseDatabase.fetchShoesByBrand(brand: any(named: 'brand')),)
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoesByCategoryAndBrand', () {
    const tCategory = 'category';
    test(
        'should return a list of shoes by category when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),),).thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
          category: tCategory, brand: tBrand,);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
          category: any(named: 'category'),
          brand: any(named: 'brand'),),).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
              category: any(named: 'category'), brand: any(named: 'brand'),),)
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
          category: tCategory, brand: tBrand,);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
              category: any(named: 'category'), brand: any(named: 'brand'),),)
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
              category: any(named: 'category'), brand: any(named: 'brand'),),)
          .thenThrow(OtherException(message: fetchShoesByCategoryErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategoryAndBrand(
          category: tCategory, brand: tBrand,);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesByCategoryErrorMessage)),
      );
      verify(() => supabaseDatabase.fetchShoesByCategoryAndBrand(
              category: any(named: 'category'), brand: any(named: 'brand'),),)
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoesSuggestions', () {

    test(
        'should return a list of shoes by suggestion when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .thenAnswer((_) async => [tShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .thenThrow(
              OtherException(message: fetchShoesSuggestionsErrorMessage),);
      // act
      final result =
          await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchShoesSuggestionsErrorMessage)),
      );
      verify(() => supabaseDatabase.fetchShoesSuggestions(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });
}
