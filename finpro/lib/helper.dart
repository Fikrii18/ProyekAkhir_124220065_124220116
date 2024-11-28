import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _imagePicker = ImagePicker();

  void getImageFromGallery(Function(String?) callback) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      callback(pickedFile?.path);
    } catch (e) {
      print('Image Picked Error $e');
    }
  }

  void getImageFromCamera(Function(String?) callback) async {
    try {
      final PickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      callback(PickedFile?.path);
    } catch (e) {
      print('Image Picked Error $e');
    }
  }
}