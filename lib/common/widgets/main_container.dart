import 'package:flutter/material.dart';
import 'package:car_reception_flutter/common/config/app_fonts.dart';

class MainContainer extends StatelessWidget {
  final String? appBarTitle;
  final Widget child;
   List<Widget>? actions = [];
  final bool isAppBar;
  final Widget? leading;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final double? padding, elevation;
  final Widget? bottomNavigationBar;

  MainContainer(
      {required this.child,
      this.backgroundColor,
      this.appBarTitle,
      this.isAppBar = true,
      this.actions,
      this.floatingActionButton,
      this.padding,
      this.elevation,
      this.leading,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: isAppBar == true
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              leading: leading,
              elevation: elevation ?? 0.0,
              centerTitle: true,
              actions: actions,
              title: Text(appBarTitle ?? '',
                  style: AppFont.Title_H6_Medium(color: Colors.white)),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding ?? 0.0),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
