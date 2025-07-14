import 'dart:convert';
import 'package:redis/redis.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/env/env.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';

typedef ShoeList = List<Shoe>;

abstract class RedisCacheService {
  Future<ShoeList> fetchLatestShoes();

  Future<ShoeList> fetchLatestShoesByBrand({required String brand});

  Future<ShoeList> fetchOtherShoes();

  Future<ShoeList> fetchOtherShoesByBrand({required String brand});

  Future<ShoeList> fetchPopularShoes();

  Future<ShoeList> fetchPopularShoesByBrand({required String brand});

  Future<Shoe> fetchShoeById({required int id});

  Future<ShoeList> fetchShoes();

  Future<ShoeList> fetchShoesByBrand({required String brand});

  Future<ShoeList> fetchShoesByCategoryAndBrand({
    required String category,
    required String brand,
  });

  Future<ShoeList> fetchShoesSuggestions({required String title});
}

class RedisCacheServiceImpl implements RedisCacheService {
  RedisCacheServiceImpl({required this.connection});
  final RedisConnection connection;
  late Command command;

  Future<void> init() async {
    try {
      command = await connection.connect(
        Env.redisHost,
        int.parse(Env.redisPort),
      );

      await command.send_object(['AUTH', Env.redisPassword]);
    } catch (e) {
      throw RedisCacheException(message: e.toString());
    }
  }

  Future<ShoeList> _fetchShoes() async {
    try {
      final result = await command.send_object(['JSON.GET', Env.cacheKey]);
      final jsonList = jsonDecode(result as String) as List<dynamic>;
      final shoes = jsonList
          .map((json) => Shoe.fromJson(json as Map<String, dynamic>))
          .toList();

      return shoes;
    } catch (e) {
      throw RedisCacheException(message: e.toString());
    }
  }

  Future<ShoeList> _filterShoes({
    required bool Function(Shoe) filter,
    required String errorMessage,
  }) async {
    final shoes = await _fetchShoes();

    final filteredShoes = shoes.where(filter).toList();

    if (filteredShoes.isEmpty) {
      throw OtherException(message: errorMessage);
    }
    return filteredShoes;
  }

  @override
  Future<ShoeList> fetchLatestShoes() async {
    return _filterShoes(
      filter: (shoe) => shoe.isNew,
      errorMessage: fetchLatestShoesErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchLatestShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => shoe.isNew && shoe.brand == brand,
      errorMessage: fetchLatestShoesByBrandErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchOtherShoes() async {
    return _filterShoes(
      filter: (shoe) => !shoe.isNew && !shoe.isPopular,
      errorMessage: fetchOtherShoesErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchOtherShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => !shoe.isNew && !shoe.isPopular && shoe.brand == brand,
      errorMessage: fetchOtherShoesByBrandErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchPopularShoes() async {
    return _filterShoes(
      filter: (shoe) => shoe.isPopular,
      errorMessage: fetchPopularShoesErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchPopularShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => shoe.isPopular && shoe.brand == brand,
      errorMessage: fetchPopularShoesByBrandErrorMessage,
    );
  }

  @override
  Future<Shoe> fetchShoeById({required int id}) async {
    try {
      final shoes = await _fetchShoes();

      final shoe = shoes.firstWhere((shoe) => shoe.id == id);

      return shoe;
    } catch (e) {
      throw RedisCacheException(message: e.toString());
    }
  }

  @override
  Future<ShoeList> fetchShoes() async {
    return _fetchShoes();
  }

  @override
  Future<ShoeList> fetchShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => shoe.brand == brand,
      errorMessage: fetchShoesByBrandErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchShoesByCategoryAndBrand({
    required String category,
    required String brand,
  }) async {
    return _filterShoes(
      filter: (shoe) => shoe.category == category && shoe.brand == brand,
      errorMessage: fetchShoesByCategoryErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchShoesSuggestions({required String title}) async {
    return _filterShoes(
      filter: (shoe) => shoe.title.contains(title),
      errorMessage: fetchShoesSuggestionsErrorMessage,
    );
  }
}
