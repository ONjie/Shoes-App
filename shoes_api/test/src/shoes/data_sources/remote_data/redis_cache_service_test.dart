import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:redis/redis.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/env/env.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/redis_cache_service.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:test/test.dart';

class MockRedisConnection extends Mock implements RedisConnection {}

class MockCommand extends Mock implements Command {}

void main() {
  late RedisCacheServiceImpl redisCacheServiceImpl;
  late MockRedisConnection mockRedisConnection;
  late MockCommand mockCommand;

  setUp(() {
    mockRedisConnection = MockRedisConnection();
    mockCommand = MockCommand();
    redisCacheServiceImpl =
        RedisCacheServiceImpl(connection: mockRedisConnection)
          ..command = mockCommand;
  });

  const latestShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['images'],
    price: 100,
    brand: 'brand',
    colors: ['colors'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'category',
    ratings: 3.5,
  );

  const popularShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['images'],
    price: 100,
    brand: 'brand',
    colors: ['colors'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: false,
    category: 'category',
    ratings: 3.5,
  );

  const otherShoe = Shoe(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['images'],
    price: 100,
    brand: 'brand',
    colors: ['colors'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: false,
    category: 'category',
    ratings: 3.5,
  );

  group('fetchLatestShoes', () {
    test('should return a list of latestShoes when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([latestShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchLatestShoes();

      //act
      expect(result, equals([latestShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchLatestShoes;

      //act
      expect(result, throwsA(isA<RedisCacheException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchLatestShoes;

      //act
      expect(result, throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchLatestShoesByBrand', () {
    test('should return a list of latestShoesByBrand when successful',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([latestShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchLatestShoesByBrand(
        brand: latestShoe.brand,
      );

      //act
      expect(result, equals([latestShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchLatestShoesByBrand;

      //act
      expect(
          result(brand: latestShoe.brand), throwsA(isA<RedisCacheException>()),);
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchLatestShoesByBrand;

      //act
      expect(result(brand: latestShoe.brand), throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchPopularShoes', () {
    test('should return a list of popularShoes when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([popularShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchPopularShoes();

      //act
      expect(result, equals([popularShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchPopularShoes;

      //act
      expect(result, throwsA(isA<RedisCacheException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchPopularShoes;

      //act
      expect(result, throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchPopularShoesByBrand', () {
    test('should return a list of popularShoesByBrand when successful',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([popularShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchPopularShoesByBrand(
        brand: popularShoe.brand,
      );

      //act
      expect(result, equals([popularShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchPopularShoesByBrand;

      //act
      expect(result(brand: popularShoe.brand),
          throwsA(isA<RedisCacheException>()),);
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchPopularShoesByBrand;

      //act
      expect(result(brand: popularShoe.brand), throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchOtherShoes', () {
    test('should return a list of popularShoes when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchOtherShoes();

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchOtherShoes;

      //act
      expect(result, throwsA(isA<RedisCacheException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchOtherShoes;

      //act
      expect(result, throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchOtherShoesByBrand', () {
    test('should return a list of otherShoesByBrand when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchOtherShoesByBrand(
        brand: otherShoe.brand,
      );

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchOtherShoesByBrand;

      //act
      expect(
          result(brand: otherShoe.brand), throwsA(isA<RedisCacheException>()),);
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchOtherShoesByBrand;

      //act
      expect(result(brand: otherShoe.brand), throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchShoeById', () {
    test('should return a shoeById when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result =
          await redisCacheServiceImpl.fetchShoeById(id: otherShoe.id);

      //act
      expect(result, equals(otherShoe));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchShoeById;

      //act
      expect(result(id: otherShoe.id), throwsA(isA<RedisCacheException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchShoes', () {
    test('should return a list of shoes when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchOtherShoes();

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchOtherShoes;

      //act
      expect(result, throwsA(isA<RedisCacheException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchShoesByBrand', () {
    test('should return a list of shoesByBrand when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result =
          await redisCacheServiceImpl.fetchShoesByBrand(brand: otherShoe.brand);

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchShoesByBrand;

      //act
      expect(
          result(brand: otherShoe.brand), throwsA(isA<RedisCacheException>()),);
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchShoesByBrand;

      //act
      expect(result(brand: otherShoe.brand), throwsA(isA<OtherException>()));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchShoesByCategory', () {
    test('should return a list of shoesByCategory when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchShoesByCategoryAndBrand(
        brand: otherShoe.brand,
        category: otherShoe.category,
      );

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchShoesByCategoryAndBrand;

      //act
      expect(
        result(brand: otherShoe.brand, category: otherShoe.category),
        throwsA(isA<RedisCacheException>()),
      );
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchShoesByCategoryAndBrand;

      //act
      expect(
        result(brand: otherShoe.brand, category: otherShoe.category),
        throwsA(isA<OtherException>()),
      );
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });

  group('fetchShoesSuggestions', () {
    test('should return a list of shoesSuggestions when successful', () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([otherShoe]));

      //act
      final result = await redisCacheServiceImpl.fetchShoesSuggestions(
        title: otherShoe.title,
      );

      //act
      expect(result, equals([otherShoe]));
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw RedisException when Redis throws Error or Exception',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenThrow(RedisError('such key does not exist'));

      //act
      final result = redisCacheServiceImpl.fetchShoesSuggestions;

      //act
      expect(
        result(title: otherShoe.title),
        throwsA(isA<RedisCacheException>()),
      );
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });

    test('should throw OtherException when Redis returns an empty list',
        () async {
      //arrange
      when(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .thenAnswer((_) async => jsonEncode([]));

      //act
      final result = redisCacheServiceImpl.fetchShoesSuggestions;

      //act
      expect(
        result(title: otherShoe.title),
        throwsA(isA<OtherException>()),
      );
      verify(() => mockCommand.send_object(['JSON.GET', Env.cacheKey]))
          .called(1);
      verifyNoMoreInteractions(mockCommand);
    });
  });
}
