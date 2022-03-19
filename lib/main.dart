import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifierでStateNotifierProvider用のクラスを作成
// <int>の部分をfreezedを用いたクラス作成にしたりする
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
  void decrement() => state--;
}

// StateNotifierProviderを作成　クラスの内容をもとに状態を管理する
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

void main() {
  // アプリを状態管理可能な状態にする
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ref.watchでProviderを使用できるようにする
    final counter = ref.watch(counterProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('StateNotifierProvider'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counter.toString(),
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Providerの値を変更する
                    ref.read(counterProvider.notifier).increment();
                  },
                  icon: Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Providerの値を変更する
                    ref.read(counterProvider.notifier).decrement();
                  },
                  icon: Icon(
                    Icons.remove,
                    size: 50,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
