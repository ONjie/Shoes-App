import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/utils/error/error_message.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/models/shoe_data.dart';
import 'package:supabase/supabase.dart';

typedef ShoeList = List<Shoe>;

abstract class SupabaseDatabase {
  Future<ShoeList> fetchShoes();

  Future<ShoeList> fetchShoesSuggestions({required String title});

  Future<Shoe> fetchShoeById({required int id});

  Future<ShoeList> fetchShoesByBrand({required String brand});

  Future<ShoeList> fetchShoesByCategory({required String category});

  Future<ShoeList> fetchLatestShoes();

  Future<ShoeList> fetchPopularShoes();

  Future<ShoeList> fetchOtherShoes();

  Future<ShoeList> fetchLatestShoesByBrand({required String brand});

  Future<ShoeList> fetchPopularShoesByBrand({required String brand});

  Future<ShoeList> fetchOtherShoesByBrand({required String brand});
}

class SupabaseDatabaseImpl implements SupabaseDatabase {
  SupabaseDatabaseImpl({required this.supabaseClient});
  final SupabaseClient supabaseClient;

  Future<ShoeList> _fecthShoesData() async {
    try {
      final results =
          await supabaseClient.from('shoes').select('shoes_data').single();

      final data = ShoesData.fromJson(results);

      return data.shoesData;
    } catch (e) {
      throw SupabaseException(message: e.toString());
    }
  }

  Future<ShoeList> _filterShoes({
    required bool Function(Shoe) filter,
    required String errorMessage,
  }) async {
    final shoes = await _fecthShoesData();

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
      filter: (shoe) => shoe.brand == brand && shoe.isNew,
      errorMessage: fetchLatestShoesByBrandErrorMessage,
    );
  }

   @override
  Future<ShoeList> fetchOtherShoes() async{
    return _filterShoes(
      filter: (shoe) => !shoe.isPopular && !shoe.isNew,
      errorMessage: fetchOtherShoesErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchOtherShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => shoe.brand == brand && !shoe.isPopular && !shoe.isNew,
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
      filter: (shoe) => shoe.brand == brand && shoe.isPopular,
      errorMessage: fetchPopularShoesByBrandErrorMessage,
    );
  }

  @override
  Future<Shoe> fetchShoeById({required int id}) async {
    try {
      final shoes = await _fecthShoesData();

      return shoes.firstWhere((shoe) => shoe.id == id);
    } catch (e) {
      throw SupabaseException(message: e.toString());
    }
  }

  @override
  Future<List<Shoe>> fetchShoes() async {
    return _fecthShoesData();
  }

  @override
  Future<ShoeList> fetchShoesByBrand({required String brand}) async {
    return _filterShoes(
      filter: (shoe) => shoe.brand == brand,
      errorMessage: fetchShoesByBrandErrorMessage,
    );
  }

  @override
  Future<ShoeList> fetchShoesByCategory({required String category}) async {
    return _filterShoes(
      filter: (shoe) => shoe.category == category,
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
