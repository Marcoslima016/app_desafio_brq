import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    APP.I.boot();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleWH: () => false,
      enableScaleText: () => true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: Modular.routerConfig,
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: context.theme.colors.primary,
              onPrimary: context.theme.colors.onPrimary,
              secondary: context.theme.colors.secondary,
              onSecondary: context.theme.colors.onSecondary,
              error: Colors.red,
              onError: Colors.white,
              surface: context.theme.colors.surface,
              onSurface: context.theme.colors.onSurface,
            ),
          ),
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              // ignore: deprecated_member_use
              data: data.copyWith(textScaleFactor: 1.0),

              child: Stack(children: [child!]),
            );
          },
        );
      },
    );
  }
}
