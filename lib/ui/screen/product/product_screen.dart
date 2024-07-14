import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/repositories/product_repository.dart';
import 'package:online_store/ui/responsive_layout_app_bar.dart';
import 'package:online_store/ui/responsive_layout_body.dart';
import 'package:online_store/ui/screen/product/bloc/product_cubit.dart';
import 'package:online_store/ui/screen/product/responsive/desktop_body_product.dart';
import 'package:online_store/ui/screen/product/responsive/mobile_body_product.dart';
import 'package:online_store/ui/widget/app_bar_desktop.dart';
import 'package:online_store/ui/widget/app_bar_mobile.dart';
import 'package:online_store/ui/widget/menu.dart';

class ProductScreenStl extends StatelessWidget {
  final int id;
  const ProductScreenStl({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ProductCubit(
            RepositoryProvider.of<ProductRepository>(context),
            id,
          ),
        child: const ProductScreenStf(),
      ),
    );
  }
}

class ProductScreenStf extends StatefulWidget {
  const ProductScreenStf({super.key});

  @override
  State<ProductScreenStf> createState() => _ProductScreenStfState();
}

class _ProductScreenStfState extends State<ProductScreenStf> {

  String _selectedLanguage = 'RU';

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().pageOpened();
  }

  void _setSelectedLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayoutAppBar(
        mobileAppBar: CustomAppBarMobile(
          selectedLanguage: _selectedLanguage,
          onLanguageSelected: _setSelectedLanguage,
        ).build(context),
        desktopAppBar: CustomAppBarDesktop(
          selectedLanguage: _selectedLanguage,
          onLanguageSelected: _setSelectedLanguage,
        ).build(context),
        context: context,

      ),
      drawer: const CustomMenu(),
      body: const ResponsiveLayoutBody(
        mobileBody: MobileBodyProduct(),
        desktopBody: DesktopBodyProduct(),
      ),
    );
  }
}

