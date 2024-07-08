import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  RxBool connectionStatus = true.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.values;
    }
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    switch (result.first) {
      case ConnectivityResult.wifi:
        connectionStatus(true);
        break;
      case ConnectivityResult.mobile:
        connectionStatus(true);
        break;
      case ConnectivityResult.none:
        connectionStatus(false);
        showNoInternetDialog();
        break;
      default:
        connectionStatus(true);
        break;
    }
  }

  void showNoInternetDialog() {
    Get.defaultDialog(
      title: 'No Internet',
      middleText: 'Please check your internet connection.',
      onConfirm: () {},
      textConfirm: 'OK',
    );
  }
}
