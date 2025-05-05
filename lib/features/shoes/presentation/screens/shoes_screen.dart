import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/shoes_bloc.dart';
import '../widgets/shoes_screen_widgets/display_searched_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/display_shoes_widget.dart';
import '../widgets/shoes_screen_widgets/shoes_brands_widget.dart';

class ShoesScreen extends StatefulWidget {
  const ShoesScreen({super.key});

  @override
  State<ShoesScreen> createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {

  late String shoeTitle = '';
  late int currentIndex = 0;
  final List<String> brandsList = [
    'Nike',
    'Adidas',
    'Puma',
    'Reebok',
  ];
  final List<String> brandsImagesList = [
    'nike_logo.png',
    'adidas_logo.png',
    'puma_logo.png',
    'reebok_logo.png',
  ];

  @override
  void initState() {
    BlocProvider.of<ShoesBloc>(context).add(FetchShoesByBrandWithFilterEvent(brand: brandsList[currentIndex],));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: buildAppBar(),
      body: shoeTitle.isEmpty ?
      buildBody(context: context)
          :
      DisplaySearchedShoesWidget(
        screenHeight: MediaQuery.of(context).size.height,
        screenWidth: MediaQuery.of(context).size.width,
      ),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 12,),
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
                ShoesBrandsWidget(
                  currentIndex: currentIndex,
                  brandsList: brandsList,
                  brandsImagesList: brandsImagesList,
                ),
                const SizedBox(height: 16,),
                const DisplayShoesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchShoeTextFormField(){
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Search for shoes',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        suffixIcon: Icon(Icons.search_outlined, color: Theme.of(context).colorScheme.secondary, size: 30,),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
      onChanged: (value){

        if(value.isEmpty){
          setState(() => shoeTitle = value);
          BlocProvider.of<ShoesBloc>(context).add(FetchShoesByBrandWithFilterEvent(brand: brandsList[currentIndex],));

        }
        else{
          setState(() => shoeTitle = value);

          BlocProvider.of<ShoesBloc>(context).add(FetchSearchedShoesEvent(shoeTitle: shoeTitle));
        }

      },
    );
  }






}
