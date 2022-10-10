import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../shared/models/user_view_model.dart';
import '../repositories/profile_repository.dart';

abstract class ProfileBaseController extends GetxController {
  final Rxn<UserViewModel> userInfo = Rxn();

  final ProfileRepository repository = ProfileRepository();

  final GetStorage _getStorage = GetStorage();

  abstract bool isProfileUser;

  @override
  void onInit() {
    super.onInit();
    if (isProfileUser) {
      _getUserInfo();
    } else {
      _getAdminInfo();
    }
  }

  Future<void> _getUserInfo() async {
    if (_getStorage.read<String>('userName') != null &&
        _getStorage.read<String>('password') != null) {
      final String userName = _getStorage.read<String>('userName')!;
      final String password = _getStorage.read<String>('password')!;

      Either<String, UserViewModel> result =
          await repository.getUserInfo(userName, password);

      await result.fold(_getUserException, _getUserSuccessful);
    }
  }

  Future<void> _getUserSuccessful(final UserViewModel user) async {
    userInfo.value = user;
  }

  Future<void> _getUserException(final String exception) async {}

  Future<void> _getAdminInfo() async {
    final Either<String, UserViewModel> result =
        await repository.getAdminInfo();
    await result.fold(
      _getAdminException,
      _getAdminSuccessful,
    );
  }

  Future<void> _getAdminSuccessful(final UserViewModel admin) async {
    userInfo.value = admin;
  }

  Future<void> _getAdminException(final String exception) async {}

  void onPressedEditInfo();
}
