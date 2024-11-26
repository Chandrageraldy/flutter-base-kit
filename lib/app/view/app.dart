import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_base_kit/app/assets/app_options.dart';
import 'package:flutter_base_kit/app/assets/app_router.dart';
import 'package:flutter_base_kit/app/viewmodel/config/theme_view_model.dart';
import 'package:flutter_base_kit/app/viewmodel/config/locale_view_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerAssets(),
      child: const AppWrapper(),
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final routerConfiguration = AppRouter.routerConfiguration();

  @override
  void initState() {
    super.initState();
    setupEasyLoading();
    // REGISTER CALLBACK THAT WILL BE INVOKED ONCE CURRENT FRAME HAS BEEN RENDERED
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.select((LocaleViewModel vm) => vm.locale);
    final appTheme = context.select((ThemeViewModel vm) => vm.themeData);
    return MaterialApp.router(
      routerConfig: routerConfiguration,
      builder: (context, child) {
        final easyLoadingInitialiser = EasyLoading.init(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaler;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: scale),
              child: child ?? const SizedBox(),
            );
          },
        );
        return easyLoadingInitialiser(context, child);
      },
      theme: appTheme,
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

extension _Init on _AppWrapperState {
  void setupEasyLoading() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }

  void checkTheme() {
    context.read<ThemeViewModel>().checkTheme();
  }
}
