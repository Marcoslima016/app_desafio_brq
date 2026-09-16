import 'package:app_desafio_brq/lib.exports.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormContainer extends StatefulWidget {
  const FormContainer({super.key});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                // width: 300.spMin,
                constraints: BoxConstraints(
                  maxWidth: 400.sp,
                ),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: context.theme.colors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    _buildTabsMenu(),
                    _buildTabContent(),
                    Text(
                      "Teste!!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabsMenu() {
    return Row(
      children: [
        IntrinsicWidth(
          child: TabBar.secondary(
            controller: _tabController,
            indicatorPadding: EdgeInsetsGeometry.only(bottom: 8.sp),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: context.theme.colors.primary,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            labelPadding: EdgeInsets.only(right: 12.sp, top: 4.sp),
            labelColor: context.theme.colors.primary,
            unselectedLabelColor: Colors.white,
            dividerColor: Colors.transparent,
            indicatorWeight: 2.5.sp,
            tabs: const <Widget>[
              Tab(text: 'Entrar'),
              Tab(text: 'Cadastrar'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    return ContentSizeTabBarView(
      controller: _tabController,
      children: <Widget>[
        // Container(
        //   width: 100,
        //   height: 100,
        //   color: Colors.red,
        // ),
        // Container(
        //   width: 100,
        //   height: 100,
        //   color: Colors.red,
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 20.sp),
          child: LoginForm(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 20.sp),
          child: LoginForm(),
        ),
      ],
    );
  }
}
