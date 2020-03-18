import 'package:flutter/material.dart';
import 'package:flutter_wechat_toast/flutter_wechat_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Column(
          children: <Widget>[
            const Expanded(
              child: const Center(
                child: const MyWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
      ],
    );
  }
}
