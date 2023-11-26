import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../data/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(Task)? onLongPress;
  const TaskTile({super.key, required this.task, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onLongPress: onLongPress != null ? () => onLongPress!(task) : null,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                TablerIcons.tools,
                color: Theme.of(context).colorScheme.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: task.title,
                    waitDuration: const Duration(milliseconds: 200),
                    child: Text(
                      task.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${task.todos?.length ?? 0} tasks',
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
