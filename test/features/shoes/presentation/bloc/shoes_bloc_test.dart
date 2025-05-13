import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/shoes/domain/entities/favorite_shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';
import 'package:shoes_app/features/shoes/presentation/bloc/shoes_bloc.dart';

class MockFetchLatestShoes extends Mock implements FetchLatestShoes {}

class MockFetchPopularShoes extends Mock implements FetchPopularShoes {}

class MockFetchOtherShoes extends Mock implements FetchOtherShoes {}

class MockFetchLatestShoesByBrand extends Mock
    implements FetchLatestShoesByBrand {}

class MockFetchPopularShoesByBrand extends Mock
    implements FetchPopularShoesByBrand {}

class MockFetchOtherShoesByBrand extends Mock
    implements FetchOtherShoesByBrand {}

class MockFetchShoe extends Mock implements FetchShoe {}

class MockFetchShoesByCategory extends Mock implements FetchShoesByCategory {}

class MockFetchShoesByBrand extends Mock implements FetchShoesByBrand {}

class MockFetchShoesSuggestions extends Mock implements FetchShoesSuggestions {}

class MockAddShoeToFavoriteShoes extends Mock
    implements AddShoeToFavoriteShoes {}

class MockFetchFavoriteShoes extends Mock implements FetchFavoriteShoes {}

class MockDeleteShoeFromFavoriteShoes extends Mock
    implements DeleteShoeFromFavoriteShoes {}

void main() {
  late ShoesBloc shoesBloc;
  late MockFetchLatestShoes mockFetchLatestShoes;
  late MockFetchPopularShoes mockFetchPopularShoes;
  late MockFetchOtherShoes mockFetchOtherShoes;
  late MockFetchLatestShoesByBrand mockFetchLatestShoesByBrand;
  late MockFetchPopularShoesByBrand mockFetchPopularShoesByBrand;
  late MockFetchOtherShoesByBrand mockFetchOtherShoesByBrand;
  late MockFetchShoesSuggestions mockFetchShoesSuggestions;
  late MockFetchShoesByBrand mockFetchShoesByBrand;
  late MockFetchShoesByCategory mockFetchShoesByCategory;
  late MockFetchShoe mockFetchShoe;
  late MockAddShoeToFavoriteShoes mockAddShoeToFavoriteShoes;
  late MockDeleteShoeFromFavoriteShoes mockDeleteShoeFromFavoriteShoes;
  late MockFetchFavoriteShoes mockFetchFavoriteShoes;

  setUp(() {
    mockFetchLatestShoes = MockFetchLatestShoes();
    mockFetchPopularShoes = MockFetchPopularShoes();
    mockFetchOtherShoes = MockFetchOtherShoes();
    mockFetchLatestShoesByBrand = MockFetchLatestShoesByBrand();
    mockFetchPopularShoesByBrand = MockFetchPopularShoesByBrand();
    mockFetchOtherShoesByBrand = MockFetchOtherShoesByBrand();
    mockFetchShoesSuggestions = MockFetchShoesSuggestions();
    mockFetchShoesByBrand = MockFetchShoesByBrand();
    mockFetchShoesByCategory = MockFetchShoesByCategory();
    mockFetchShoe = MockFetchShoe();
    mockAddShoeToFavoriteShoes = MockAddShoeToFavoriteShoes();
    mockDeleteShoeFromFavoriteShoes = MockDeleteShoeFromFavoriteShoes();
    mockFetchFavoriteShoes = MockFetchFavoriteShoes();
    shoesBloc = ShoesBloc(
      fetchLatestShoes: mockFetchLatestShoes,
      fetchPopularShoes: mockFetchPopularShoes,
      fetchOtherShoes: mockFetchOtherShoes,
      fetchLatestShoesByBrand: mockFetchLatestShoesByBrand,
      fetchPopularShoesByBrand: mockFetchPopularShoesByBrand,
      fetchOtherShoesByBrand: mockFetchOtherShoesByBrand,
      fetchShoesSuggestions: mockFetchShoesSuggestions,
      fetchShoesByBrand: mockFetchShoesByBrand,
      fetchShoesByCategory: mockFetchShoesByCategory,
      fetchShoe: mockFetchShoe,
      addShoeToFavoriteShoes: mockAddShoeToFavoriteShoes,
      deleteShoeFromFavoriteShoes: mockDeleteShoeFromFavoriteShoes,
      fetchFavoriteShoes: mockFetchFavoriteShoes,
    );
  });

  const tShoe = ShoeEntity(
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

  const tPopularShoe = ShoeEntity(
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

  const tLatestShoe = ShoeEntity(
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

  const tOtherShoe = ShoeEntity(
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

  const tFavoriteShoe = FavoriteShoeEntity(
    id: 1,
    shoeId: 9,
    title: 'Title',
    image: 'image1',
    price: 100,
    ratings: 2.5,
    isFavorite: true,
  );

  const tBrand = 'brand';

  const errorMessage = 'Not Found';

  group('_onFetchShoesByBrandWithFilter', () {
    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.shoesFetched] when successful',
      setUp: () {
        when(
          () => mockFetchLatestShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer((_) async => const Right([tLatestShoe]));
        when(
          () => mockFetchPopularShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer((_) async => const Right([tPopularShoe]));
        when(
          () => mockFetchOtherShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer((_) async => const Right([tOtherShoe]));
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const FetchShoesByBrandWithFilterEvent(brand: tBrand)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.shoesFetched,
              latestShoesByBrand: [tLatestShoe],
              popularShoesByBrand: [tPopularShoe],
              otherShoesByBrand: [tOtherShoe],
            ),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchedShoesError] when unsuccessful',
      setUp: () {
        when(
          () => mockFetchLatestShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );

        when(
          () => mockFetchPopularShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
        when(
          () => mockFetchOtherShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const FetchShoesByBrandWithFilterEvent(brand: tBrand)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchShoesError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onFetchSearchedShoes', () {
    const tShoeTitle = 'title';

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.searchedShoesFetched] when successful',
      setUp: () {
        when(
          () => mockFetchShoesSuggestions.call(
            shoeTitle: any(named: 'shoeTitle'),
          ),
        ).thenAnswer((_) async => const Right([tShoe]));
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const FetchSearchedShoesEvent(shoeTitle: tShoeTitle)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.searchedShoesFetched,
              searchedShoes: [tShoe],
            ),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchSearchedShoesError] when unsuccessful',
      setUp: () {
        when(
          () => mockFetchShoesSuggestions.call(
            shoeTitle: any(named: 'shoeTitle'),
          ),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const FetchSearchedShoesEvent(shoeTitle: tShoeTitle)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchSearchShoesError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onFetchShoesByBrand', () {
    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.shoesByBrandFetched] when successful',
      setUp: () {
        when(
          () => mockFetchShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer((_) async => const Right([tShoe]));
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const FetchShoesByBrandEvent(brand: tBrand)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.shoesByBrandFetched,
              shoesByBrand: [tShoe],
            ),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchShoesByBrandError] when unsuccessful',
      setUp: () {
        when(
          () => mockFetchShoesByBrand.call(brand: any(named: 'brand')),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const FetchShoesByBrandEvent(brand: tBrand)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchShoesByBrandError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onFetchShoesByCategory', () {
    const tCategory = 'Men';

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.shoesByCategoryFetched] when successful',
      setUp: () {
        when(
          () => mockFetchShoesByCategory.call(
            category: any(named: 'category'),
            brand: any(named: 'brand'),
          ),
        ).thenAnswer((_) async => const Right([tShoe]));
      },
      build: () => shoesBloc,
      act:
          (bloc) => bloc.add(
            const FetchShoesByCategoryEvent(brand: tBrand, category: tCategory),
          ),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.shoesByCategoryFetched,
              shoesByCategory: [tShoe],
            ),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchShoeByCategoryError] when unsuccessful',
      setUp: () {
        when(
          () => mockFetchShoesByCategory.call(
            category: any(named: 'category'),
            brand: any(named: 'brand'),
          ),
        ).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act:
          (bloc) => bloc.add(
            const FetchShoesByCategoryEvent(brand: tBrand, category: tCategory),
          ),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchShoesByCategoryError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onFetchShoe', () {
    const tShoeId = 1;

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.shoeFetched] when successful',
      setUp: () {
        when(
          () => mockFetchShoe.call(shoeId: any(named: 'shoeId')),
        ).thenAnswer((_) async => const Right(tShoe));
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const FetchShoeEvent(shoeId: tShoeId)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(shoesStatus: ShoesStatus.shoeFetched, shoe: tShoe),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchShoeError] when unsuccessful',
      setUp: () {
        when(() => mockFetchShoe.call(shoeId: any(named: 'shoeId'))).thenAnswer(
          (_) async => const Left(ServerFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const FetchShoeEvent(shoeId: tShoeId)),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchShoeError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onFetchFavoriteShoes', () {
    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.favoriteShoesFetched] when successful',
      setUp: () {
        when(
          () => mockFetchFavoriteShoes.call(),
        ).thenAnswer((_) async => const Right([tFavoriteShoe]));
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(FetchFavoriteShoesEvent()),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.favoriteShoesFetched,
              favoriteShoes: [tFavoriteShoe],
            ),
          ],
    );

    blocTest(
      'should emit [ShoesStatus.loading, ShoesStatus.fetchFavoriteShoesError] when unsuccessful',
      setUp: () {
        when(() => mockFetchFavoriteShoes.call()).thenAnswer(
          (_) async => const Left(LocalDatabaseFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(FetchFavoriteShoesEvent()),
      expect:
          () => [
            const ShoesState(shoesStatus: ShoesStatus.loading),
            const ShoesState(
              shoesStatus: ShoesStatus.fetchFavoriteShoesError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onAddShoeToFavoriteShoes', () {
    blocTest(
      'should emit [] when successful',
      setUp: () {
        when(
          () => mockAddShoeToFavoriteShoes.call(shoe: tShoe),
        ).thenAnswer((_) async => const Right(tFavoriteShoe));
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const AddShoeToFavoriteShoesEvent(shoe: tShoe)),
      expect: () => null,
    );

    blocTest(
      'should emit [ShoesStatus.addShoeToFavoriteShoesError] when unsuccessful',
      setUp: () {
        when(() => mockAddShoeToFavoriteShoes.call(shoe: tShoe)).thenAnswer(
          (_) async => const Left(LocalDatabaseFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act: (bloc) => bloc.add(const AddShoeToFavoriteShoesEvent(shoe: tShoe)),
      expect:
          () => [
            const ShoesState(
              shoesStatus: ShoesStatus.addShoeToFavoriteShoesError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });

  group('_onDeleteShoeFromFavoriteShoes', () {
    const tShoeId = 1;
    blocTest(
      'should emit [] when successful',
      setUp: () {
        when(
          () => mockDeleteShoeFromFavoriteShoes.call(
            shoeId: any(named: 'shoeId'),
          ),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const DeleteShoeFromFavoriteShoesEvent(shoeId: tShoeId)),
      expect: () => null,
    );

    blocTest(
      'should emit [ShoesStatus.deleteShoeFromFavoriteShoesError] when unsuccessful',
      setUp: () {
        when(
          () => mockDeleteShoeFromFavoriteShoes.call(
            shoeId: any(named: 'shoeId'),
          ),
        ).thenAnswer(
          (_) async => const Left(LocalDatabaseFailure(message: errorMessage)),
        );
      },
      build: () => shoesBloc,
      act:
          (bloc) =>
              bloc.add(const DeleteShoeFromFavoriteShoesEvent(shoeId: tShoeId)),
      expect:
          () => [
            const ShoesState(
              shoesStatus: ShoesStatus.deleteShoeFromFavoriteShoesError,
              errorMessage: errorMessage,
            ),
          ],
    );
  });
}
