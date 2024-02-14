import 'package:assignment/model/age_group.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  final List<AgeGroup> ageGroups;
  final AgeGroup? selectedAgeGroup;

  const FilterScreen({super.key, required this.selectedAgeGroup, required this.ageGroups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: const Text(
              'Clear Filters',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ageGroups.length,
        itemBuilder: (context, index) {
          final AgeGroup ageGroup = ageGroups[index];
          final isSelected = selectedAgeGroup != null &&
              ageGroup.lowerBound == selectedAgeGroup!.lowerBound &&
              ageGroup.upperBound == selectedAgeGroup!.upperBound;

          return ListTile(

            title: Row(
              children: [
                Text(
                  'Age Group: ${ageGroup.lowerBound} - ${ageGroup.upperBound}',
                ),
              ],
            ),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () {
              Navigator.pop(context, ageGroup);
            },
          );
        },
      ),
    );
  }
}
