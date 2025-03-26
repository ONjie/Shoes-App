import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

import '../../../../../../routes/api/v1/shoes/fetch_popular_shoes/index.dart'
    as route;

class _MockRequestContext extends Mock implements RequestContext {}

class MockRequest extends Mock implements Request {}

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late _MockRequestContext mockRequestContext;
  late MockShoesRepository mockShoesRepository;
  late MockRequest mockRequest;

  setUp(() {
    mockRequestContext = _MockRequestContext();
    mockShoesRepository = MockShoesRepository();
    mockRequest = MockRequest();

    when(() => mockRequestContext.request).thenReturn(mockRequest);
    when(() => mockRequestContext.read<ShoesRepository>())
        .thenReturn(mockShoesRepository);
  });

  group('GET /', () {
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
        'should HttpStatus.notFound and an error message when fetchPopularShoes returns a Left',
        () async {
      //arrange
      when(() => mockRequest.method).thenReturn(HttpMethod.get);
      when(
        () => mockShoesRepository.fetchPopularShoes(),
      ).thenAnswer(
        (_) async => const Left(
          SupabaseFailure(message: supabaseDatabaseError),
        ),
      );

      //act
      final response = await route.onRequest(mockRequestContext);

      final body = jsonDecode(await response.body()) as Map<String, dynamic>;

      //assert
      expect(response.statusCode, equals(HttpStatus.notFound));
      expect(body['error'], equals(supabaseDatabaseError));

      verify(() => mockRequest.method).called(1);
      verify(() => mockRequestContext.request).called(1);
      verify(() => mockRequestContext.read<ShoesRepository>()).called(1);
      verify(
        () => mockShoesRepository.fetchPopularShoes(),
      ).called(1);

      verifyNoMoreInteractions(mockRequestContext);
      verifyNoMoreInteractions(mockShoesRepository);
    });

    test(
        'should HttpStatus.ok and a Json list of shoes when fetchPopularShoes returns a Right',
        () async {
      //arrange
      when(() => mockRequest.method).thenReturn(HttpMethod.get);
      when(
        () => mockShoesRepository.fetchPopularShoes(),
      ).thenAnswer(
        (_) async => const Right([tShoe]),
      );

      //act
      final response = await route.onRequest(mockRequestContext);

      final body = jsonDecode(await response.body()) as List<dynamic>;

      //assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(body, equals([tShoe.toJson()]));

      verify(() => mockRequest.method).called(1);
      verify(() => mockRequestContext.request).called(1);
      verify(() => mockRequestContext.read<ShoesRepository>()).called(1);
      verify(() => mockShoesRepository.fetchPopularShoes()).called(1);

      verifyNoMoreInteractions(mockRequestContext);
      verifyNoMoreInteractions(mockShoesRepository);
    });
  });
}
