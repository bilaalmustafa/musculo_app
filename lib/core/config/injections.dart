import 'package:get_it/get_it.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/core/services/user_service.dart';

GetIt instance = GetIt.instance;

initlocator() {
  instance.registerSingleton<AuthService>(AuthService());
 instance.registerSingleton<UserService>(UserService());
 instance.registerSingleton<ProgramServices>(ProgramServices());
  instance.registerSingleton<WorkoutServices>(WorkoutServices());
}
