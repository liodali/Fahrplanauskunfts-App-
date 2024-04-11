import 'dart:io';

import 'package:app_theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/src/commons/use_init.dart';
import 'package:timetabl_app/src/view/pages/home/home.dart';
import 'package:timetabl_app/src/viewmodel/commons.dart';

void main() =>
  runApp(
    const FireBaseIntegrationWidget(
      child: ProviderScope(
        child: MyApp(),
      ),
    ),
  );


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: appMode.toThemeMode(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const Home(),
    );
  }
}

class FireBaseIntegrationWidget extends HookWidget {
  final Widget child;
  const FireBaseIntegrationWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    useInitState(() {
      Future.delayed(Duration.zero, () async {
        await dotenv.load(fileName: '.env');
        await Firebase.initializeApp(
            options: FirebaseOptions(
          apiKey:dotenv.env['apiKey']!,
          appId: Platform.isIOS
              ? dotenv.env['appIdiOS']!
              : dotenv.env['appIdAndroid']!,
          messagingSenderId:
              Platform.isIOS ? dotenv.env['messagingSenderIdiOS']! : "",
          projectId: dotenv.env['projectId']!,
        ));
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      });
    });
    return child;
  }
}
