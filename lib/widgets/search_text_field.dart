import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';

class SearchTextField extends StatelessWidget {
  /// Optional focus node to manage keyboard focus for the search text field
  final FocusNode? focusNode;

  /// Whether the search text field is enabled for user interaction
  final bool searchFieldEnabled;

  /// Optional custom input decoration for styling the search text field
  final InputDecoration? inputDecoration;

  /// Optional text editing controller to programmatically manage the search input
  final TextEditingController? searchTextController;

  /// The keyboard action button type (e.g., done, search, next)
  final TextInputAction keyboardAction;

  /// The type of keyboard to display (e.g., text, number, email)
  final TextInputType textInputType;

  /// Whether to hide the text input (used for password fields)
  final bool obscureText;

  /// Determines when filtering occurs: on text edit or on submit
  final SearchMode searchMode;

  /// Callback function that receives the search query to filter the list
  final Function(String) filterList;

  /// Optional callback function invoked when the user submits the search
  final Function(String)? onSubmitSearch;

  /// Whether to display a clear icon in the search field suffix
  final bool displayClearIcon;

  /// Whether to display a search icon in the search field suffix
  final bool displaySearchIcon;

  /// The color of the suffix icons (clear and search icons)
  final Color defaultSuffixIconColor;

  /// The size of the suffix icons
  final double defaultSuffixIconSize;

  /// Optional custom text style for the search input text
  final TextStyle? textStyle;

  /// Optional custom color for the text cursor
  final Color? cursorColor;

  /// Maximum number of lines for the search text field
  final int? maxLines;

  /// Maximum character length allowed in the search field
  final int? maxLength;

  /// The horizontal alignment of the text within the search field
  final TextAlign textAlign;

  /// The vertical alignment of the text within the search field
  final TextAlignVertical verticalTextAlign;

  /// List of autocomplete hints to suggest to the user while typing
  final List<String> autoCompleteHints;

  /// Optional widget to display next to the search field (e.g., filter button)
  final Widget? secondaryWidget;

  /// Optional callback function invoked when the sort button is tapped
  final Function()? onSortTap;

  /// Optional custom widget for the sort button
  final Widget? sortWidget;

  /// Optional label text displayed when the search field is empty
  final String? labelText;

  final FormFieldValidator<String>? validator;

  final Key? formFieldKey;

  const SearchTextField({
    Key? key,
    required this.filterList,
    required this.focusNode,
    required this.inputDecoration,
    required this.keyboardAction,
    required this.obscureText,
    required this.onSubmitSearch,
    required this.searchFieldEnabled,
    required this.searchMode,
    required this.searchTextController,
    required this.textInputType,
    required this.displayClearIcon,
    required this.displaySearchIcon,
    required this.defaultSuffixIconColor,
    required this.defaultSuffixIconSize,
    required this.textStyle,
    required this.cursorColor,
    required this.maxLines,
    required this.maxLength,
    required this.textAlign,
    required this.autoCompleteHints,
    required this.verticalTextAlign,
    this.onSortTap,
    this.secondaryWidget,
    this.sortWidget,
    this.labelText,
    this.validator,
    this.formFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _renderForm(context),
        ),
        if (secondaryWidget != null) secondaryWidget!,
      ],
    );
  }

  /// Renders the search text field wrapped in a Form widget if a formFieldKey is provided, otherwise renders just the text field
  Widget _renderForm(BuildContext context) {
    if (formFieldKey != null) {
      return Form(
        key: formFieldKey,
        child: _renderFieldWidget(context),
      );
    } else {
      return _renderFieldWidget(context);
    }
  }

  /// Renders either an Autocomplete widget or a standard TextFormField based on whether autocomplete hints are provided
  Widget _renderFieldWidget(BuildContext context) {
    if (autoCompleteHints.isNotEmpty) {
      return _autoCompleteFieldBuilder(context);
    } else {
      return _renderTextField(context);
    }
  }

  /// Renders an Autocomplete widget with the provided hints and behavior for selecting options and submitting the search query
  Widget _autoCompleteFieldBuilder(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (textEditingValue) {
        return autoCompleteHints;
      },
      onSelected: (option) {
        filterList(option.toString());
        FocusScope.of(context).requestFocus(FocusNode());
      },
      fieldViewBuilder: (
        context,
        textController,
        focusNode,
        onFieldSubmitted,
      ) {
        return _renderFieldWidget(context);
      },
    );
  }

  /// Renders the main search text field with appropriate styling, behavior, and suffix icons based on the provided parameters
  Widget _renderTextField(BuildContext context) {
    return TextFormField(
      textAlignVertical: verticalTextAlign,
      cursorColor: cursorColor,
      maxLength: maxLength,
      maxLines: maxLines,
      textAlign: textAlign,
      focusNode: focusNode,
      enabled: searchFieldEnabled,
      decoration: inputDecoration ??
          InputDecoration(
            labelText: labelText,
            suffixIcon: _renderSuffixWidget(context),
          ),
      style: textStyle,
      controller: searchTextController,
      textInputAction: keyboardAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      onFieldSubmitted: (value) {
        onSubmitSearch?.call(value);
        if (searchMode == SearchMode.onSubmit) {
          filterList(value);
        }
      },
      validator: validator,
      onChanged: (value) {
        if (searchMode == SearchMode.onEdit) {
          filterList(value);
        }
      },
    );
  }

  /// Renders the suffix widget for the search text field, including clear and sort icons if applicable
  Widget _renderSuffixWidget(BuildContext context) {
    var clearIcon = _renderClearIcon();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (displayClearIcon && clearIcon != null)
            Padding(
              padding: const EdgeInsets.only(
                right: 5,
              ),
              child: clearIcon,
            ),
          if (sortWidget != null)
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
                onSortTap?.call();
              },
              child: sortWidget,
            ),
        ],
      ),
    );
  }

  Widget? _renderClearIcon() {
    if (searchTextController!.text.isNotEmpty) {
      return InkWell(
        onTap: () {
          searchTextController?.clear();
          filterList(searchTextController?.text ?? '');
        },
        child: Icon(
          Icons.clear,
          size: defaultSuffixIconSize,
          color: defaultSuffixIconColor,
        ),
      );
    } else if (displaySearchIcon) {
      return Icon(
        Icons.search,
        size: defaultSuffixIconSize,
        color: defaultSuffixIconColor,
      );
    }
    return null;
  }
}
