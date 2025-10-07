import 'package:instagram_clone/features/app/presentation/app.dart';
import 'package:instagram_clone/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
