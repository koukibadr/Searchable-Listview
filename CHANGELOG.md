## 2.19.1 - 14/07/2025

- **Bug Fix**
  - Fix separator builder rendering issue [ISSUE#149](https://github.com/koukibadr/Searchable-Listview/issues/149)

## 2.19.0 - 03/06/2025

- **Changes**
  - Added `showSearchField` parameter to show/hide the search field widget [PR#144](https://github.com/koukibadr/Searchable-Listview/pull/144) [ISSUE#74](https://github.com/koukibadr/Searchable-Listview/issues/74)
- **Bug Fix**
  - Fix filtred list rendering when using SearchableListView in a bottom sheet modal [PR#143](https://github.com/koukibadr/Searchable-Listview/pull/143) [ISSUE#140](https://github.com/koukibadr/Searchable-Listview/issues/140)

## 2.18.0 - 31/05/2025

- **Changes**
  - Added `labelText` String attribute to display default label in search field when the `inputDecoration` is null [PR#141](https://github.com/koukibadr/Searchable-Listview/pull/141)
- **Bug Fix**
  - Fix suffix widget rendering when input decoration is not null [PR#141](https://github.com/koukibadr/Searchable-Listview/pull/141)

## 2.17.3 - 13/05/2025

- **Changes**
  - Update suffix widget rendering with input decoration parameter [RR#137](https://github.com/koukibadr/Searchable-Listview/pull/137)

## 2.17.2 - 29/04/2025

- **Bug Fix**
  - Fix sort and filter widget rendering with input field decoration [PR#132](https://github.com/koukibadr/Searchable-Listview/pulls?q=is%3Apr+is%3Aclosed) [Issue#131](https://github.com/koukibadr/Searchable-Listview/issues/131)

## 2.17.1 - 27/04/2025

- **Bug Fix**
  - Fix searchable textview vertical alignment by adding `textAlignVertical` parameter [PR#132](https://github.com/koukibadr/Searchable-Listview/pulls?q=is%3Apr+is%3Aclosed) [Issue#131](https://github.com/koukibadr/Searchable-Listview/issues/131)

## 2.17.0- 12/04/2025

- **Enhancement**
  - Update simple searchable listview rendering method for optimized performance.
  - Update expansion listview rendering method for optimized performance.
  - Update sliver searchable listview rendering method for optimized performance.
  - Remove `spaceBetweenSearchAndList` attribute and replace it with `searchFieldPadding` attribute for better padding control.

## 2.16.0- 02/12/2024

- **Enhancement**

  - Add rendering with simple `Listview` with `lazyLoadingEnabled` attribute that indicates whether searchable listview will use `Listview.builder` or simple `Listview`
  - new attribute `searchFieldPadding` of type `EdgeInsets` replace `spaceBetweenSearchAndList` with more Padding options.

- **Changes**
  - Empty widget attribute is now nullable, when it's nullable a `Sizedbox.shrink()` will be rendered when the list is empty
  - Renaming `style` attribute to `textStyle`

## 2.15.2- 01/09/2024

- **Bug Fix**
  - Handle expansion controller error when controller state is null (expansion item not shown in the screen) [PR](https://github.com/koukibadr/Searchable-Listview/pull/119)

## 2.15.1- 21/08/2024

- **Enhancements**
  - Unregister from text controller listener when disposing the searchable listview widget [PR](https://github.com/koukibadr/Searchable-Listview/pull/117)

## 2.15.0- 06/08/2024

- **Changes**

  - Remove `onItemSelected` as it's set deprecated [PR](https://github.com/koukibadr/Searchable-Listview/pull/110)

- **Enhancements**
  - Update pagination rendering with setState when onPaginate is triggered [PR](https://github.com/koukibadr/Searchable-Listview/pull/114)

## 2.14.1 - 12/07/2024

- **Enhancements**
  - Set `onItemSelected` as deprecated and will be removed in the next release [PR](https://github.com/koukibadr/Searchable-Listview/pull/110)

## 2.14.0 - 25/05/2024

- **Enhancements**
  - Expand all expansion tiles when searching [PR#108](https://github.com/koukibadr/Searchable-Listview/pull/108)

## 2.13.0 - 17/05/2024

- **Enhancements**
  - Remove `builder` callback attribute and replace it with `itemBuilder`
  - Add `displaySearchIcon` attribute
  - Add `clearIconSize` attribute
  - Add `searchFieldHeight` and `searchFieldWidth` constraints as attributes
  - Improve widget tree rendering for textfield widget when `displayClearIcon` and `displaySearchIcon` are enabled.

## 2.12.0 - 30/04/2024

- **Enhancements**
  - Mark `builder` callback as deprecated and introduced `itemBuilder` attribute

## 2.11.2 - 13/04/2024

- **Fix Bug**
  - Update sort widget display : remove `displaySortWidget` and add `sortWidget` to expansion and sliver constructors [Issue#89](https://github.com/koukibadr/Searchable-Listview/issues/89) [PR#99](https://github.com/koukibadr/Searchable-Listview/pull/99)
  - Add listener to search text field controller [Issue#87](https://github.com/koukibadr/Searchable-Listview/issues/87) [PR#100](https://github.com/koukibadr/Searchable-Listview/pull/100)

## 2.11.1 - 20/03/2024

- **Fix Bug**
  - Update rendering clear icon when `displayClearIcon == false` and `inputDecoration != null` [Issue#90](https://github.com/koukibadr/Searchable-Listview/issues/90)

## 2.11.0 - 16/03/2024

- **Enhancements**
  - Expose the item model in `expansionListBuilder` when rendering searchable expansion list
  - Expose the expansion group index in `expansionListBuilder` callback
  - Display the `emptyWidget` when all the expansion lists are empty (in previous version empty expansions were shown)
  - Add `hideEmptyExpansionItems` to indicate whether the expansion will be shown or not when the expansion group is empty
  - Add `expansionTileEnabled` to indicate the expansion tile `enable` value

## 2.10.2 - 24/02/2024

- **Fix Bug**
  - Keep keyboard state when search value is changing (keyboard closing issue fix) [Related PR](https://github.com/koukibadr/Searchable-Listview/pull/92)

## 2.10.1 - 24/01/2024

- **Fix Bug**
  - Fix field clear button when `autoCompleteHints` is used

## 2.10.0 - 07/01/2024

- **Enhancements**
  - `closeKeyboardWhenScrolling` added to close automatically keyboard when scrolling [issue-85](https://github.com/koukibadr/Searchable-Listview/issues/85)
  - `scrollController` added to main widget to control scroll on listview or add listener on scolling

## 2.9.1 - 03/12/2023

- **Bug Fix**
  - Suffix icon not displayed when suffixIcon not null [PR#83](https://github.com/koukibadr/Searchable-Listview/pull/83)

## 2.9.0 - 18/11/2023

- **Enhancement**
  - Add sort list items feature (`displaySortWidget`, `sortWidget` and `sortPredicate`) [PR#78](https://github.com/koukibadr/Searchable-Listview/pull/80)

## 2.8.0 - 29/10/2023

- **Enhancement**
  - Remove `seperated` constructor (replace by `seperatorBuilder` attribute in the default constructor and `async` constructor) [PR#78](https://github.com/koukibadr/Searchable-Listview/pull/78)
  - Refactor `renderAsyncList` callback code [PR#77](https://github.com/koukibadr/Searchable-Listview/pull/77)

## 2.7.1 - 27/09/2023

- Update package license to MIT license

## 2.7.0 - 06/09/2023

- Update simple searchable list state management
- Create seperate async consrtuctor for rendering async listview
- Update `builder` callback by adding `list` and `item` parameters providing the rendered list and the current rendered item
- `SearchableList.seperated` is now deprecated and it will be no longer available in the future versions

## 2.6.1 - 27/08/2023

- Update listview builder callback definition (Exposing two parameters : actual index and initial index) (Issue : [#66](https://github.com/koukibadr/Searchable-Listview/issues/66))

## 2.5.1 - 20/08/2023

- Fix build callback index attribute (Issue : [#66](https://github.com/koukibadr/Searchable-Listview/issues/66))

## 2.5.0 - 12/08/2023

- Add list index availability in builder callback [#59](https://github.com/koukibadr/Searchable-Listview/issues/59)
- Add shrink wrap and physics attributes [#61](https://github.com/koukibadr/Searchable-Listview/issues/61)

## 2.4.0 - 16/04/2023

- Add support to expansion lists
- Filter expansion lists

## 2.3.2 - 30/03/2023

- Add secondary widget display alongside search field

## 2.2.2 - 19/02/2023

- Fix keyboard closing issue [#48](https://github.com/koukibadr/Searchable-Listview/issues/48)

## 2.2.1 - 27/11/2022

- Add autocomplete options attribute

## 2.1.1 - 19/09/2022

- Add textfield parameters
- Add padding between textfield and list attribute

## 2.0.1 - 27/08/2022

- Fix text style parameter integration

## 2.0.0 - 01/08/2022

- Support async callback on rendering list
- Display loading when async call is loading
- Display Error widget when async callback return error
- Filter async callback result list

## 1.7.2 - 14/07/2022

- Enhance widget rendering

## 1.7.1 - 10/07/2022

- Update project documentation

## 1.7.0 - 10/07/2022

- Customizable text field position
- Support pagination

## 1.6.1 - 27/06/2022

- Update package documentation

## 1.6.0 - 05/06/2022

- Searchable list with divider
- Seperated sliver effect constructor
- Enhanced code version with Flutter 3 support
- Scroll direction parameter

## 1.5.3 - 25/05/2022

- Fix onItemPressed attibute
- Fix bugs

## 1.5.2 - 27/04/2022

- Enhanced attributes checking

## 1.5.1 - 17/04/2022

- Update search type enum name
- Perform iOS upgrade check
- Bug fixes

## 1.5.0 - 14/04/2022

- Add sliver scroll effect
- Bug fixes

## 1.4.0 - 02/04/2022

- Add pull to refresh behaviour to the list
- Bug fixes

## 1.3.5 - 25/03/2022

- Enhance package coding style (remove dynamic)
- Bug fixes

## 1.3.4 - 10/03/2022

- Fix list state issue on update list

## 1.3.3 - 03/03/2022

- Fix input decoration bug

## 1.3.2 - 27/02/2022

- Add clear button suffix icon

## 1.3.1 - 25/01/2022

- Bug fixes

## 1.3.0 - 25/01/2022

- Add customization to search field text style

## 1.2.0 - 21/01/2022

- Enhanced widget parameters
- bug fixes

## 1.1.0 - 05/01/2022

- Add on item pressed callback parameter
- bug fixes

## 1.0.0 - 18/12/2021

- Filter list view easily
- Display custom widget when list is empty
- Customize search text field
- Change keyboard input type and keyboard submit button
- Add focus on search text field
