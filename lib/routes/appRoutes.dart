abstract class Routes {
  Routes._();

  static const LOGIN = Paths.LOGIN;
  static const HOME = Paths.HOME;
  static const PROFILE = Paths.PROFILE;
}

abstract class Paths {
  static const LOGIN = '/login';
  static const HOME = '/chatroom';
  static const PROFILE = '/profile';
}
