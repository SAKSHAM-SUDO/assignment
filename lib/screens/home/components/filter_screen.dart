import 'package:assignment/model/age_group.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  final List<AgeGroup> ageGroups;

  const FilterScreen(this.ageGroups, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: const Icon(Icons.highlight_remove_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: ageGroups.length,
        itemBuilder: (context, index) {
          final AgeGroup ageGroup = ageGroups[index];
          return ListTile(
            title: Text(
              'Age Group: ${ageGroup.lowerBound} - ${ageGroup.upperBound}',
            ),
            onTap: () {
              Navigator.pop(context, ageGroup);
            },
          );
        },
      ),
    );
  }
}
