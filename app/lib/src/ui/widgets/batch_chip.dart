import 'package:flutter/material.dart';

import '../../data/models/batch_model.dart';
import '../../utils.dart';

class BatchChip extends StatelessWidget {
  final BatchModel? batch;
  final VoidCallback? onTap;

  const BatchChip({
    super.key,
    this.batch,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final code = batch?.batchCode ?? '空';
    final display = displayBatchCode(code, maxLength: 18);

    return ActionChip(
      avatar: batch != null ? const Icon(Icons.inventory_2_outlined) : const Icon(Icons.add),
      label: Text(display),
      onPressed: onTap,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
