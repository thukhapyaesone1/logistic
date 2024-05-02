import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension DurationExtension on num{
  Duration get second => Duration(seconds: toInt());

  Duration get hour => Duration(hours: toInt());

  Duration get minute => Duration(minutes: toInt());

  Duration get millisecond => Duration(milliseconds: toInt());

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

}

extension PaddingExtension on (num,num){
  EdgeInsets get padding => EdgeInsets.symmetric(vertical: $1.toDouble(), horizontal: $2.toDouble());
}

