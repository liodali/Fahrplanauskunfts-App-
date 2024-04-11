import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timetabl_app/src/commons/commons.dart';
import 'package:timetabl_app/src/model/search_state.dart';
import 'package:timetabl_app/src/viewmodel/search_vm.dart';

class SearchWidget extends HookConsumerWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final textEditingController = useTextEditingController();
    final memSearch = useValueNotifier(
      textEditingController.text,
      [textEditingController.text],
    );
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final isValid = useState(false);
    return Form(
      key: formKey,
      onChanged: () {
        isValid.value = (formKey.currentState?.validate() ?? false) &&
            textEditingController.text.isNotEmpty;
      },
      child: Column(
        children: [
          SearchTextField(
            textFieldController: textEditingController,
            onActionSubmit: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onSubmitSearch(
                ref.read(searchProvider.notifier),
                memSearch,
                textEditingController,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SearchActionWidget(
              isValid: isValid,
              onClear: () => textEditingController.clear(),
              onSubmit: () {
                FocusScope.of(context).requestFocus(FocusNode());
                onSubmitSearch(
                  ref.read(searchProvider.notifier),
                  memSearch,
                  textEditingController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onSubmitSearch(
    SearchNotifier searchVM,
    ValueNotifier<String> memSearch,
    TextEditingController textEditingController,
  ) {
    if (memSearch.value.isEmpty ||
        memSearch.value != textEditingController.text) {
      searchVM.searchStartPoint(textEditingController.text);
      memSearch.value = textEditingController.text;
    }
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String label;
  final Function onActionSubmit;
  const SearchTextField({
    super.key,
    required this.textFieldController,
    this.label = "StartPoint",
    required this.onActionSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (_) => onActionSubmit(),
      validator: (value) {
        if (value != null && value.isNotEmpty && value.length < 3) {
          return "minimum seach text accepted should have 3 characters";
        } else if (value != null && regexWhiteSpace.hasMatch(value)) {
          return "search text should not end with whitespace";
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        labelText: label,
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

class SearchActionWidget extends ConsumerWidget {
  final Function onSubmit;
  final Function onClear;
  final ValueNotifier isValid;

  const SearchActionWidget({
    super.key,
    required this.onSubmit,
    required this.onClear,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(searchProvider
        .select((searchState) => searchState is LoadingState ? true : false));
    final hasData = ref.watch(searchProvider.select((searchState) =>
        searchState is SearchState && searchState.location.isNotEmpty
            ? true
            : false));

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: hasData && !isLoading
              ? () {
                  onClear();
                  ref.read(searchProvider.notifier).reset();
                }
              : null,
          style: AppButtonStyle.flat.configuration.style,
          child: const Text("Clear"),
        ).padding(
          const EdgeInsets.only(
            right: 6,
          ),
        ),
        ElevatedButton(
          onPressed: isValid.value && !isLoading ? () => onSubmit() : null,
          style: AppButtonStyle.elevated.configuration.style,
          child: const Text("Search"),
        ),
      ],
    );
  }
}
