import 'package:flutter/material.dart';
import 'package:sample_lib/delta/delta.dart' as delta;

final _searchBoxController = TextEditingController();
final _focusNode = FocusNode();

class Toolbar extends StatelessWidget {
  const Toolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Row(
        children: [
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 240,
                    child: delta.SearchBox(
                      focusNode: _focusNode,
                      controller: _searchBoxController,
                      hintText: 'Search orders/products here',
                      onSuggestion: (pattern) async {
                        if (pattern == 'a') {
                          return [
                            delta.SearchSuggestion('a'),
                            delta.SearchSuggestion('b'),
                            delta.SearchSuggestion('c'),
                          ];
                        }
                        if (pattern == 'b') {
                          return [];
                        }
                        return [
                          delta.SearchSuggestion('hello'),
                          delta.SearchSuggestion('world'),
                        ];
                      },
                    ))),
          ),
        ],
      ),
    );
  }
}
/*
 */