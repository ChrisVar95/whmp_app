import 'package:get/get.dart';
import 'package:whmp_app/app/data/providers/task/provider.dart';
import 'package:whmp_app/app/data/services/storage/repository.dart';
import 'package:whmp_app/app/modules/home/controller.dart';

class HomeBindng implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
