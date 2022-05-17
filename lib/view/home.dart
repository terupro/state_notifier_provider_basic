import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// <int>の部分に操作したいEntityを指定する
class CounterNotifier extends StateNotifier<int> {
  // 初期値
  CounterNotifier() : super(0);

  // 値の操作を行う (state = StateNotifier<int>)
  void plus() => state++;
  void minus() => state--;
}

// 「CounterNotifier」の内容を持つ「counterProvider」を作成
final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 「counterProvider」の値
    final _counterProvider = ref.watch(counterProvider);
    // 「counterProvider」の操作
    final _counterNotifier = ref.watch(counterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _counterProvider.toString(),
              style: const TextStyle(fontSize: 80),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // プラスする
                    _counterNotifier.plus();
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 30,
                ),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () {
                    // マイナスする
                    _counterNotifier.minus();
                  },
                  icon: const Icon(Icons.remove),
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
