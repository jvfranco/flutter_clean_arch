import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';
import 'package:hyrule/screens/details.dart';

class EntryCard extends StatelessWidget {
  EntryCard({super.key, required this.entry, required this.isSaved});

  final Entry entry;
  final bool isSaved;

  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        direction:
            isSaved ? DismissDirection.endToStart : DismissDirection.none,
        key: ValueKey<int>(entry.id),
        onDismissed: (direction) {
          daoController.deleteEntry(entry: entry);
        },
        background: Container(
          color: Colors.red,
          child: const Center(child: Icon(Icons.delete)),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(entry: entry),
                  ),
                );
              },
              child: Ink(
                child: Row(
                  children: [
                    Image.network(entry.image),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.name),
                        Text(entry.description),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Wrap(
              children: entry
                  .commonLocationsConverter()
                  .map(
                    (e) => Chip(
                      label: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
