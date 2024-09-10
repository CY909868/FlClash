import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';

const actions = [
  "启动/暂停",
  "显示/隐藏",
  "切换模式",
  "系统代理",
  "虚拟网卡",
];

class HotKeyFragment extends StatelessWidget {
  const HotKeyFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: actions.length,
      itemBuilder: (_, index) {
        return ListItem(
          title: Text(actions[index]),
          onTap: (){

          },
        );
      },
    );
  }
}
