import 'package:instagram_clone/app/app.dart';
import 'package:instagram_clone/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
