import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
        HomeModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton<AppBloc>(AppBloc.new);
    i.add<IInitializeApp>(InitializeApp.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) {
        return Container(color: Colors.grey[800]);
      },
    );

    r.module(
      '/home',
      module: HomeModule(),
    );

    r.module(
      '/auth',
      module: AuthModule(),
    );
  }
}
