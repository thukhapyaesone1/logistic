import 'package:flutter/material.dart';

enum ButtonStatus { start, loading, fail, success }

enum PickingStatus { ready, loading, done }

extension PickingStatusExtension on PickingStatus {
  Color get color {
    switch (this) {
      case PickingStatus.ready:
        return Colors.grey.shade50;
      case PickingStatus.loading:
        return Colors.yellowAccent.shade100;
      case PickingStatus.done:
        return Colors.green.shade50;
      default:
        return Colors.grey.shade50;
    }
  }
}
