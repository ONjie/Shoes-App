import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/shoes/data/data_sources/remote_data/shoes_api_service.dart';
import 'package:shoes_app/features/shoes/data/models/shoe_model.dart';

class MockDio extends Mock implements Dio {}

typedef MapJson = Map<String, dynamic>;

void main() {
  late ShoesApiServiceImpl shoesApiServiceImpl;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    shoesApiServiceImpl = ShoesApiServiceImpl(dio: mockDio);
  });

  void setUpDioSuccess({required MapJson responseData}) {
    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        statusCode: HttpStatus.ok,
        data: [responseData],
      ),
    );
  }

  void setUpDioFailure() {
    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
        response: Response(
          requestOptions: RequestOptions(),
          data: {'error': 'Not Found'},
        ),
      ),
    );
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
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": false,
            "isNew": true,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchLatestShoes();

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tLatestShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test('should throw ServerException when DioException is thrown', () async {
      //arrange
      setUpDioFailure();

      //act
      final call = shoesApiServiceImpl.fetchLatestShoes;

      //assert
      //expect(result, isA<List<ShoeModel>>());
      expect(() => call(), throwsA(isA<ServerException>()));
      verify(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).called(1);
      verifyNoMoreInteractions(mockDio);
    });
  });

  group('fetchLatestShoesByBrand', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": false,
            "isNew": true,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchLatestShoesByBrand(
          brand: tBrand,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tLatestShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchLatestShoesByBrand;

        //assert
        expect(() => call(brand: tBrand), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    
  });

  group('fetchOtherShoes', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": false,
            "isNew": false,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchOtherShoes();

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tOtherShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchOtherShoes;

        //assert
        expect(() => call(), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

  });

  group('fetchOtherShoesByBrand', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": false,
            "isNew": false,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchOtherShoesByBrand(
          brand: tBrand,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tOtherShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchOtherShoesByBrand;

        //assert
        expect(() => call(brand: tBrand), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

   
  });

  group('fetchPopularShoes', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": true,
            "isNew": false,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchPopularShoes();

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tPopularShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchPopularShoes;

        //assert
        expect(() => call(), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

  });

  group('fetchPopularShoesByBrand', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": true,
            "isNew": false,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchPopularShoesByBrand(
          brand: tBrand,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tPopularShoe]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchPopularShoesByBrand;

        //assert
        expect(() => call(brand: tBrand), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

   
  });

  group('fetchShoe', () {
    const tShoeId = 1;
    test(
      'should perform a GET request on the URL and return ShoeModel if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: HttpStatus.ok,
            data: {
              "id": 1,
              "title": "title",
              "description": "description",
              "images": ["image1", "image2", "image3"],
              "price": 100,
              "brand": "brand",
              "colors": ["color1", "color2", "color3"],
              "sizes": [1, 2, 3, 4, 5],
              "isPopular": true,
              "isNew": true,
              "category": "category",
              "ratings": 1.5,
              "isFavorite": false,
            },
          ),
        );

        //act
        final result = await shoesApiServiceImpl.fetchShoe(shoeId: tShoeId);

        //assert
        expect(result, isA<ShoeModel>());
        expect(result, equals(tShoeModel));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchShoe;

        //assert
        expect(() => call(shoeId: tShoeId), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );
  });

  group('fetchShoesByBrand', () {
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": true,
            "isNew": true,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchShoesByBrand(
          brand: tBrand,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tShoeModel]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchShoesByBrand;

        //assert
        expect(() => call(brand: tBrand), throwsA(isA<ServerException>()));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );
  });

  group('fetchShoesByCategory', () {
    const tCategory = 'category';
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": true,
            "isNew": true,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchShoesByCategory(
          category: tCategory,
          brand: tBrand,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tShoeModel]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchShoesByCategory;

        //assert
        expect(
          () => call(category: tCategory, brand: tBrand),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );
  });

  group('fetchShoesSuggestions', () {
    const tShoeTitle = 'title';
    test(
      'should perform a GET request on the URL and return List<ShoeModel> if StatusCode == HttpStatus.ok',
      () async {
        //arrange
        setUpDioSuccess(
          responseData: {
            "id": 1,
            "title": "title",
            "description": "description",
            "images": ["image1", "image2", "image3"],
            "price": 100,
            "brand": "brand",
            "colors": ["color1", "color2", "color3"],
            "sizes": [1, 2, 3, 4, 5],
            "isPopular": true,
            "isNew": true,
            "category": "category",
            "ratings": 1.5,
            "isFavorite": false,
          },
        );

        //act
        final result = await shoesApiServiceImpl.fetchShoesSuggestions(
          shoeTitle: tShoeTitle,
        );

        //assert
        expect(result, isA<List<ShoeModel>>());
        expect(result, equals([tShoeModel]));
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should throw ServerException when DioException is thrown',
      () async {
        //arrange
        setUpDioFailure();

        //act
        final call = shoesApiServiceImpl.fetchShoesSuggestions;

        //assert
        expect(
          () => call(shoeTitle: tShoeTitle),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

  });
}
