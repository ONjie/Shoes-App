import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/supabase_database.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

import 'shoes_repository_test.mocks.dart';



@GenerateNiceMocks([MockSpec<SupabaseDatabase>()])
void main() {
  late MockSupabaseDatabase supabaseDatabase;
  late ShoesRepositoryImpl shoesRepositoryImpl;

  setUp(() {
    supabaseDatabase = MockSupabaseDatabase();
    shoesRepositoryImpl =
        ShoesRepositoryImpl(supabaseDatabase: supabaseDatabase);
  });

  const tBrand = 'brand';

  group('fetchLatestShoes', () {
    const tShoe = Shoe(
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
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of latest shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchLatestShoes())
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchLatestShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchLatestShoes())
          .thenThrow(OtherException(message: fetchLatestShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchLatestShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchLatestShoesErrorMessage)),
      );
      verify(supabaseDatabase.fetchLatestShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchLatestShoesbyBrand', () {
    const tShoe = Shoe(
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
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of latest shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).thenAnswer((_) async => [tShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchLatestShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchLatestShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchOtherShoes', () {
    const tShoe = Shoe(
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
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of other shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchOtherShoes()).thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchOtherShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchOtherShoes())
          .thenThrow(OtherException(message: fetchOtherShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchOtherShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchOtherShoesErrorMessage)),
      );
      verify(supabaseDatabase.fetchOtherShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchOtherShoesbyBrand', () {
    const tShoe = Shoe(
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
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of other shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).thenAnswer((_) async => [tShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchOtherShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchOtherShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchPopularShoes', () {
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
      isNew: false,
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of popular shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchPopularShoes())
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchPopularShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchPopularShoes())
          .thenThrow(OtherException(message: fetchPopularShoesErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchPopularShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const OtherFailure(message: fetchPopularShoesErrorMessage)),
      );
      verify(supabaseDatabase.fetchPopularShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchPopularShoesbyBrand', () {
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
      isNew: false,
      category: 'Men',
      ratings: 1.5,
    );

    test(
        'should return a list of popular shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).thenAnswer((_) async => [tShoe]);

      // act
      final result =
          await shoesRepositoryImpl.fetchPopularShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
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
        supabaseDatabase.fetchPopularShoesByBrand(
          brand: anyNamed('brand'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoeById', () {
    const tShoe = Shoe(
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
      category: 'Men',
      ratings: 1.5,
    );

    test('should return a shoe when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoeById(id: anyNamed('id')))
          .thenAnswer((_) async => tShoe);

      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Right<Failure, Shoe>>());
      expect(result.right, equals(tShoe));
      verify(supabaseDatabase.fetchShoeById(id: anyNamed('id'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoeById(id: anyNamed('id')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoeById(id: tShoe.id);

      // assert
      expect(result, isA<Left<Failure, Shoe>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(supabaseDatabase.fetchShoeById(id: anyNamed('id'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoes', () {
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

    test(
        'should return a list of shoes when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoes()).thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoes())
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoes();

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(
        result.left,
        equals(const SupabaseFailure(message: supabaseDatabaseError)),
      );
      verify(supabaseDatabase.fetchShoes()).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoesByBrand', () {
    const tShoe = Shoe(
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

    test(
        'should return a list of shoes by brand when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand')))
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const SupabaseFailure(message: supabaseDatabaseError)),);
      verify(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand')))
          .thenThrow(OtherException(message: fetchShoesByBrandErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByBrand(brand: tBrand);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const OtherFailure(message: fetchShoesByBrandErrorMessage)),);
      verify(supabaseDatabase.fetchShoesByBrand(brand: anyNamed('brand'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

 group('fetchShoesByCategory', () {
    const tShoe = Shoe(
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

    test(
        'should return a list of shoes by category when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category')))
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategory(category: tShoe.category);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategory(category: tShoe.category);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const SupabaseFailure(message: supabaseDatabaseError)),);
      verify(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category')))
          .thenThrow(OtherException(message: fetchShoesByCategoryErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesByCategory(category: tShoe.category);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const OtherFailure(message: fetchShoesByCategoryErrorMessage)),);
      verify(supabaseDatabase.fetchShoesByCategory(category: anyNamed('category'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

  group('fetchShoesSuggestions', () {
    const tShoe = Shoe(
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

    test(
        'should return a list of shoes by suggestion when the call to SupabaseDatabase is successful',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title')))
          .thenAnswer((_) async => [tShoe]);

      // act
      final result = await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Right<Failure, List<Shoe>>>());
      expect(result.right, equals([tShoe]));
      verify(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a SupabaseFailure when SupabaseException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title')))
          .thenThrow(SupabaseException(message: supabaseDatabaseError));
      // act
      final result = await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const SupabaseFailure(message: supabaseDatabaseError)),);
      verify(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });

    test(
        'should return a OtherFailure when OtherException is thrown by SupabaseDatabase',
        () async {
      // arrange
      when(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title')))
          .thenThrow(OtherException(message: fetchShoesSuggestionsErrorMessage));
      // act
      final result = await shoesRepositoryImpl.fetchShoesSuggestions(title: tShoe.title);

      // assert
      expect(result, isA<Left<Failure, List<Shoe>>>());
      expect(result.left,
          equals(const OtherFailure(message: fetchShoesSuggestionsErrorMessage)),);
      verify(supabaseDatabase.fetchShoesSuggestions(title: anyNamed('title'))).called(1);
      verifyNoMoreInteractions(supabaseDatabase);
    });
  });

}
