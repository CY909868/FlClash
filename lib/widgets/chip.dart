import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/material.dart';

class CommonChip extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ChipType type;
  final Widget? avatar;

  const CommonChip({
    super.key,
    required this.label,
    this.onPressed,
    this.avatar,
    this.type = ChipType.action,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ChipType.delete) {
      return Chip(
        avatar: avatar,
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 4,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onDeleted: onPressed ?? () {},
        side:
            BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        label: Text(label),
      );
    }
    return ActionChip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: avatar,
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 4,
      ),
      onPressed: onPressed ?? () {},
      side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      label: Text(label),
    );
  }
}
