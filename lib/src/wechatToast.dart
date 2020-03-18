import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// WechatToast might help you build a wechat styled toast animation
///
class WechatToast {
  /// build context
  final BuildContext context;

  /// mask will forbid users operation before toast finished
  final bool mask;

  /// display duration
  final Duration duration;

  /// borderRadius you are prefered
  final BorderRadiusGeometry borderRadius;

  /// elevation
  final double elevation;


  /// icon and text  color
  final Color color;

  WechatToast(
      {@required this.context,
      this.mask = true,
      this.elevation = 4,
      this.borderRadius = const BorderRadius.all(const Radius.circular(10)),
      this.color = const Color(0xFFF2F2F2),
      this.duration = const Duration(seconds: 1)});

  ///
  /// open a failed toast by giving message
  /// icon is customizable
  ///
  Future<void> failed({String message = 'Failed', Widget icon}) async {
    final Function close =
        _showOverlay(icon: icon ?? Icons.remove_circle, text: message);

    await Future.delayed(const Duration(seconds: 2));
    close();
  }

  ///
  /// show info without an icon
  /// icon is customizable
  ///
  Future<void> info(String message) async {
    final Function close = _showOverlay(text: message);

    await Future.delayed(const Duration(seconds: 2));
    close();
  }

  ///
  /// show loading
  /// you will get a function, use this function to close loading
  /// icon is customizable
  ///
  Function loading({String message = 'Loading', Widget icon}) {
    final Widget brightIndicator = Transform.scale(
      scale: 1.4,
      child: Theme(
          data: ThemeData(
              cupertinoOverrideTheme:
                  CupertinoThemeData(brightness: Brightness.dark)),
          child: CupertinoActivityIndicator()),
    );

    final Function close =
        _showOverlay(icon: icon ?? brightIndicator, text: message);
    return close;
  }

  ///
  /// show success
  /// icon is customizable
  ///
  Future<void> success({String message = 'OK', Widget icon}) async {
    final Function close =
        _showOverlay(icon: icon ?? Icons.check, text: message);
    await Future.delayed(const Duration(seconds: 2));
    close();
  }

  ///
  /// show overlay
  ///
  Function _showOverlay({dynamic icon, String text}) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          final Widget toast =
              _buildOverlay(context: context, icon: icon, text: text);

          if (mask) {
            return _buildMask(child: toast);
          }

          return toast;
        },
        maintainState: false,
        opaque: false);

    overlayState.insert(overlayEntry);

    return overlayEntry.remove;
  }

  ///
  /// build overlay entry
  ///
  Widget _buildOverlay({
    BuildContext context,
    dynamic icon,
    String text,
  }) =>
      Center(
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 100,
            height: 110,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.78),
                  borderRadius: borderRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  icon == null ? const SizedBox() : _buildIcon(icon: icon),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: color),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  /// build mask
  Widget _buildMask({Widget child}) =>
      Stack(alignment: Alignment.center, children: [
        const Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: const SizedBox(
                child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.transparent),
            ))),
        // mask
        child
      ]);

  ///
  /// build icon
  Widget _buildIcon({dynamic icon}) => icon.runtimeType == IconData
      ? Icon(icon, size: 40, color: color)
      : icon;
}
