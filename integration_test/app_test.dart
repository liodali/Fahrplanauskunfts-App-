import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/main.dart';

void main() {
  testWidgets("test app with faker request", (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pump();
    expect(find.byType(TextFormField), findsOne);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
}
