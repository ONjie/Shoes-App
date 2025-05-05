

import 'package:dio/dio.dart';
import 'package:shoes_app/core/core.dart';

import '../../models/shoe_model.dart';

typedef ShoeModelList = List<ShoeModel>;

typedef MapJson = Map<String, dynamic>;

abstract class ShoesApiService {
  Future<ShoeModelList> fetchLatestShoes();
  Future<ShoeModelList> fetchLatestShoesByBrand({required String brand});
  Future<ShoeModelList> fetchPopularShoes();
  Future<ShoeModelList> fetchPopularShoesByBrand({required String brand});
  Future<ShoeModelList> fetchOtherShoes();
  Future<ShoeModelList> fetchOtherShoesByBrand({required String brand});
  Future<ShoeModelList> fetchShoesByBrand({required String brand});
  Future<ShoeModelList> fetchShoesByCategory({
    required String category,
    required String brand,
  });
  Future<ShoeModel> fetchShoe({required int shoeId});
  Future<ShoeModelList> fetchShoesSuggestions({required String shoeTitle});
}

class ShoesApiServiceImpl implements ShoesApiService {
  ShoesApiServiceImpl({required this.dio});

  final Dio dio;

  Future<ShoeModelList> _fetchShoes({
    required String url,
    required MapJson queryPrams,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryPrams);

      final data = response.data as List<dynamic>;
      final shoes = data.map((e) => ShoeModel.fromJson(e)).toList();
      return shoes;
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['error']);
    }
  }

  @override
  Future<ShoeModelList> fetchLatestShoes() async {
    return await _fetchShoes(url: fetchLatestShoesEndpoint, queryPrams: {});
  }

  @override
  Future<ShoeModelList> fetchLatestShoesByBrand({required String brand}) async {
    return await _fetchShoes(
      url: fetchLatestShoesByBrandEndpoint,
      queryPrams: {'brand': brand},
    );
  }

  @override
  Future<ShoeModelList> fetchOtherShoes() async {
    return await _fetchShoes(url: fetchOtherShoesEndpoint, queryPrams: {});
  }

  @override
  Future<ShoeModelList> fetchOtherShoesByBrand({required String brand}) async {
    return await _fetchShoes(
      url: fetchOtherShoesByBrandEndpoint,
      queryPrams: {'brand': brand},
    );
  }

  @override
  Future<ShoeModelList> fetchPopularShoes() async {
    return await _fetchShoes(url: fetchPopularShoesEndpoint, queryPrams: {});
  }

  @override
  Future<ShoeModelList> fetchPopularShoesByBrand({
    required String brand,
  }) async {
    return await _fetchShoes(
      url: fetchPopularShoesByBrandEndpoint,
      queryPrams: {'brand': brand},
    );
  }

  @override
  Future<ShoeModel> fetchShoe({required int shoeId}) async {
    try {
      final response = await dio.get(
        fetchShoeByIdEndpoint,
        queryParameters: {'id': shoeId},
      );

      return ShoeModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['error']);
    }
  }

  @override
  Future<ShoeModelList> fetchShoesByBrand({required String brand}) async {
    return await _fetchShoes(
      url: fetchShoesByBrandEndpoint,
      queryPrams: {'brand': brand},
    );
  }

  @override
  Future<ShoeModelList> fetchShoesByCategory({
    required String category,
    required String brand,
  }) async {
    return await _fetchShoes(
      url: fetchShoesByCategoryEndpoint,
      queryPrams: {'category': category, 'brand': brand},
    );
  }

  @override
  Future<ShoeModelList> fetchShoesSuggestions({
    required String shoeTitle,
  }) async {
    return await _fetchShoes(
      url: fetchShoesSuggestionsEndpoint,
      queryPrams: {'title': shoeTitle},
    );
  }
}
