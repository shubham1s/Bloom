import 'package:flutter/material.dart';
import 'package:BLOOM_BETA/example/lib/presentation/pages/splash/translator.dart';

/// Page to shown loading when the app is started
/// it will be shown until app checks authentication
class SplashPage extends StatelessWidget {
  /// Provides instance of [SplashPage]
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${'Bloom'.tr()} ${'loading'.tr()}",
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 15),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
