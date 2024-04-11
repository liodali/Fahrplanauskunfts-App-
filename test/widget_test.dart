// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/src/view/pages/home/widgets/search.dart';

void main() {
  testWidgets('text search without validation', (WidgetTester tester) async {
    final textController = TextEditingController();
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchTextField(
            textFieldController: textController,
            onActionSubmit: () {},
          ),
        ),
      ),
    );
    expect(find.byType(TextFormField), findsOne);
    await tester.pump();
    await tester.enterText(find.byType(TextFormField), "12");
    await tester.pump();
    expect(find.text("12"), findsOne);
    expect(find.text("minimum seach text accepted should have 3 characters"),
        findsNothing);
  });
  testWidgets('text search with validation length',
      (WidgetTester tester) async {
    final textController = TextEditingController();
    final globalK = GlobalKey<FormState>();
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: globalK,
            child: SearchTextField(
              textFieldController: textController,
              onActionSubmit: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(TextFormField), findsOne);
    expect(find.byType(Form), findsOne);
    await tester.enterText(find.byType(TextFormField), "12");
    await tester.pump();
    globalK.currentState!.validate();
    await tester.pump();
    expect(find.text("12"), findsOne);
    expect(find.text("minimum seach text accepted should have 3 characters"),
        findsOne);
    await tester.enterText(find.byType(TextFormField), "1234");
    await tester.pump();
    globalK.currentState!.validate();
    await tester.pump();
    expect(find.text("minimum seach text accepted should have 3 characters"),
        findsNothing);
  });

  testWidgets("test search action widget", (tester) async {
    final isValid = ValueNotifier<bool>(false);
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ValueListenableBuilder(
                valueListenable: isValid,
                builder: (context, _, __) {
                  debugPrint("${isValid.value}");
                  return SearchActionWidget(
                    isValid: isValid,
                    onSubmit: () {
                      isValid.value = false;
                    },
                    onClear: () {},
                  );
                }),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.text("Search"), findsOne);
    expect(find.text("Clear"), findsOne);
    var seachButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).last);
    expect(seachButton.onPressed, null);
    isValid.value = true;
    await tester.pump();
    seachButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).last);
    expect(seachButton.onPressed != null, true);
  });
}
