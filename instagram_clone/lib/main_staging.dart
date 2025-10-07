import 'package:instagram_clone/bootstrap.dart';
import 'package:instagram_clone/features/app/presentation/app.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
