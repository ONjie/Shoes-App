import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/features/shoes/domain/entities/brand_entity.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/core.dart';
import '../bloc/shoes_bloc.dart';
import '../widgets/shoes_screen_widgets/display_latest_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/display_other_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/display_popular_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/display_searched_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/shoes_brands_widget.dart';

class ShoesScreen extends StatefulWidget {
  const ShoesScreen({super.key});

  @override
  State<ShoesScreen> createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {
  late String shoeTitle = '';
  late int currentIndex = 0;
  late List<ShoeEntity> latestShoesByBrand = ShoeEntity.mockShoes;
  late List<ShoeEntity> popularShoesByBrand = ShoeEntity.mockShoes;
  late List<ShoeEntity> otherShoesByBrand = ShoeEntity.mockShoes;
  final List<BrandEntity> brands = BrandEntity.brands;

   bool isLoading = true;

  @override
  void initState() {
   BlocProvider.of<ShoesBloc>(
      context,
    ).add(FetchShoesByBrandWithFilterEvent(brand: brands[currentIndex].brand));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: buildAppBar(),
      body:
          shoeTitle.isEmpty
              ? buildBody(context: context)
              : DisplaySearchedShoesWidget(
                screenHeight: MediaQuery.of(context).size.height,
                screenWidth: MediaQuery.of(context).size.width,
              ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: buildSearchShoeTextFormField(),
        ),
      ),
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
            child: Column(
              children: [
                ShoesBrandsWidget(currentIndex: currentIndex,),
                const SizedBox(height: 16),
                displayShoesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchShoeTextFormField() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Search for shoes',
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontSize: 20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        suffixIcon: Icon(
          Icons.search_outlined,
          color: Theme.of(context).colorScheme.secondary,
          size: 30,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() => shoeTitle = value);
          BlocProvider.of<ShoesBloc>(context).add(
            FetchShoesByBrandWithFilterEvent(brand: brands[currentIndex].brand),
          );
        } else {
          setState(() => shoeTitle = value);

          BlocProvider.of<ShoesBloc>(
            context,
          ).add(FetchSearchedShoesEvent(shoeTitle: shoeTitle));
        }
      },
    );
  }

  Widget displayShoesWidget() {
    return BlocConsumer<ShoesBloc, ShoesState>(
      listener: (context, state) {
        if (state.shoesStatus == ShoesStatus.loading) {
          setState(() {
            isLoading = true;
            latestShoesByBrand = ShoeEntity.mockShoes;
            popularShoesByBrand =  ShoeEntity.mockShoes;
            otherShoesByBrand =  ShoeEntity.mockShoes;
            
          });
        }
        if (state.shoesStatus == ShoesStatus.shoesFetched) {
          setState(() {
            latestShoesByBrand = state.latestShoesByBrand!;
            popularShoesByBrand = state.popularShoesByBrand!;
            otherShoesByBrand = state.otherShoesByBrand!;
            isLoading = false;
          });
        }
      },
      builder: (context, state) {

        if (state.shoesStatus == ShoesStatus.fetchShoesError) {
          return ErrorStateWidget(message: state.errorMessage!);
        }
        return Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          effect: ShimmerEffect(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            duration: Duration(seconds: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              latestShoesByBrand.isNotEmpty
                  ? DisplayLatestShoesWidget(latestShoes: latestShoesByBrand)
                  : const SizedBox(),
              const SizedBox(height: 16),
              popularShoesByBrand.isNotEmpty
                  ? DisplayPopularShoesWidget(popularShoes: popularShoesByBrand)
                  : const SizedBox(),
              const SizedBox(height: 16),
              otherShoesByBrand.isNotEmpty
                  ? DisplayOtherShoesWidget(otherShoes: otherShoesByBrand)
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
