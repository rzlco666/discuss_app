import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/c_search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerSearch = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: controllerSearch,
            decoration: InputDecoration(
              hintText: 'Search...',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: Colors.white54,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  /*if(controllerSearch.text != '') {
                    context.read<CSearch>().search(controllerSearch.text);
                  }*/
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: context.watch<CSearch>().filter,
              items: context.watch<CSearch>().filters.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                context.read<CSearch>().filter = value!;
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              underline: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
