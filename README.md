# flutter_wechat_toast

A wechat styled toast plugin. This package is quite simple, only 3 methods requied. Make sure you need it or this will be your best choise before your installation.


<p>
<img width="200" src="https://github.com/virskor/flutterWechatToast/raw/master/QQ20200318-153813@2x.png"/>
<img width="200" src="https://github.com/virskor/flutterWechatToast/raw/master/QQ20200318-153829@2x.png"/>
<img width="200" src="https://github.com/virskor/flutterWechatToast/raw/master/QQ20200318-153837@2x.png"/>
</p>

## install
Add following item into your pubspec.yaml
```yaml
flutter_wechat_toast: ^1.0.1
```

Recommened you install it from git repo. because this package may contains bugs or changes.

## Examples and Noticing
This package required 3 methods to build a toast widget.  
You can using await to wait toast widget dismissed.

```dart
text() async{
    await WechatToast(context: context).failed(message: '操作失败');
    print('done');
}
```

### Parameters
Create a toast widget, you can specify these arguments.

```dart
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
```

### Demo:

```dart
import 'package:flutter_wechat_toast/flutter_wechat_toast.dart';

/// ...
MaterialButton(
    child: Text('Toast failed'),
    onPressed: () => WechatToast(context: context).failed(message: '操作失败'),
),
MaterialButton(
    child: Text('Toast success'),
    onPressed: () =>
        WechatToast(context: context).success(message: '操作成功'),
),
    MaterialButton(
    child: Text('Toast loading'),
    onPressed: () async{
    final Function close =  WechatToast(context: context).loading(message: '加载中');

    await Future.delayed(const Duration(seconds: 5));
    close();
    },
),
MaterialButton(
    child: Text('Toast success and remove Mask'),
    onPressed: () =>
        WechatToast(context: context, mask: false).success(message: '无遮罩'),
),
```