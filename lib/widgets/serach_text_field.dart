import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final bool searchFieldEnabled;
  final InputDecoration? inputDecoration;
  final TextEditingController? searchTextController;
  final TextInputAction keyboardAction;
  final TextInputType textInputType;
  final bool obscureText;
  final SearchMode searchMode;
  final Function(String) filterList;
  final Function(String)? onSubmitSearch;
  final bool displayClearIcon;
  final Color defaultSuffixIconColor;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;

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
    required this.defaultSuffixIconColor,
    required this.textStyle,
    required this.cursorColor,
    required this.maxLines,
    required this.maxLength,
    required this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: cursorColor,
      maxLength: maxLength,
      maxLines: maxLines,
      textAlign: textAlign,
      focusNode: focusNode,
      enabled: searchFieldEnabled,
      decoration: inputDecoration?.copyWith(
        suffix: inputDecoration?.suffix ?? _renderSuffixIcon(),
      ),
      style: textStyle,
      controller: searchTextController,
      textInputAction: keyboardAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      onSubmitted: (value) {
        onSubmitSearch?.call(value);
        if (searchMode == SearchMode.onSubmit) {
          filterList(value);
        }
      },
      onChanged: (value) {
        if (searchMode == SearchMode.onEdit) {
          filterList(value);
        }
      },
    );
  }

  Widget? _renderSuffixIcon() {
    return !displayClearIcon
        ? null
        : searchTextController!.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  searchTextController!.clear();
                  filterList(searchTextController?.text ?? '');
                },
                child: Icon(
                  Icons.clear,
                  color: defaultSuffixIconColor,
                ),
              )
            : Icon(
                Icons.search,
                color: defaultSuffixIconColor,
              );
  }
}
