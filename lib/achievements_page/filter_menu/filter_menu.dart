import 'package:achievements/achievements_page/achievements_page_lists.dart';
import 'package:achievements/achievements_page/filter_menu/expansion_pack_button.dart';
import 'package:achievements/achievements_page/filter_menu/expansion_pack_model.dart';
import 'package:achievements/achievements_page/filter_menu/filter_button.dart';
import 'package:achievements/achievements_page/wish_list_builder.dart';
import 'package:flutter/material.dart';

class FilterMenu extends StatefulWidget {
  const FilterMenu(
      {super.key,
      required this.filteringList,
      required this.toggledPacks,
      this.onFilterButtonTap});

  final List<WishModel> filteringList;
  final List<ExpansionPackModel> toggledPacks;
  final Function? onFilterButtonTap;

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  void _filterWishes(String key) {
    for (var wish in AchievementPageLists.wishes) {
      if (wish.expansionPackKey == key) {
        widget.filteringList.add(wish);
      }
    }
  }

  void _addToggledPackToList(ExpansionPackModel pack) {
    if (widget.toggledPacks.contains(pack)) {
      debugPrint('pack removed from list');
      widget.toggledPacks.remove(pack);
    } else {
      debugPrint('pack added to list');
      widget.toggledPacks.add(pack);
    }

    debugPrint('_addToggledPackToList setState');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Filter menu',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Wrap(
                runSpacing: 5,
                children: [
                  for (var pack in AchievementPageLists.expansionPacks)
                    ExpansionPackButton(
                      pack: pack,
                      isToggled: widget.toggledPacks.contains(pack),
                      onTap: () {
                        _addToggledPackToList(pack);
                      },
                    ),
                ],
              ),
            ),
            FilterButton(
              onTap: (){
                _startFilter();
                _closeEndDrawer();
              },
              text: 'Filter wishes',
            ),
            const SizedBox(height: 15,),
            FilterButton(
              onTap: (){
                widget.toggledPacks.clear();
                setState(() {});
              },
              text: 'Reset filters',
            ),
          ],
        ),
      ),
    );
  }

  void _startFilter() {
    widget.filteringList.clear();
    if (widget.toggledPacks.isEmpty) {
      widget.filteringList.addAll(AchievementPageLists.wishes);
      setState(() {});
    }

    for (var pack in widget.toggledPacks) {
      _filterWishes(pack.key);
    }

    if (widget.onFilterButtonTap != null) {
      widget.onFilterButtonTap!();
    }
  }
}


