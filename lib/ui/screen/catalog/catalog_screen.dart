import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/repositories/catalog_repository.dart';
import 'package:online_store/ui/responsive_layout_app_bar.dart';
import 'package:online_store/ui/responsive_layout_body.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_cubit.dart';
import 'package:online_store/ui/screen/catalog/responsive/desktop_body_catalog.dart';
import 'package:online_store/ui/screen/catalog/responsive/mobile_body_catalog.dart';
import 'package:online_store/ui/widget/app_bar_desktop.dart';
import 'package:online_store/ui/widget/app_bar_mobile.dart';
import 'package:online_store/ui/widget/menu.dart';

class CatalogScreenStl extends StatelessWidget {
  const CatalogScreenStl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CatalogCubit(
          RepositoryProvider.of<CatalogRepository>(context),
        ),
        child: const CatalogScreenStf(),
      ),
    );
  }
}

class CatalogScreenStf extends StatefulWidget {
  const CatalogScreenStf({super.key});

  @override
  State<CatalogScreenStf> createState() => _CatalogScreenStfState();
}

class _CatalogScreenStfState extends State<CatalogScreenStf> {
  String _selectedLanguage = 'RU';

  @override
  void initState() {
    super.initState();
    context.read<CatalogCubit>().pageOpened();
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
        mobileBody: CatalogMobileBody(),
        desktopBody: CatalogDesktopBody(),
      ),
    );
  }
}
