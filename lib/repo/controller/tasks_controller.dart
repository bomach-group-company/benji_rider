import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/models/tasks.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TasksController extends GetxController {
  static TasksController get instance {
    return Get.find<TasksController>();
  }

  var tasks = <TasksModel>[].obs;
  var acceptedTasks = <TasksModel>[].obs;

  setTasks(List taskList) {
    List<TasksModel> newTasks = [];
    List<TasksModel> newAccptedTasks = [];
    for (var task in taskList) {
      TasksModel newTask = TasksModel.fromJson(task);
      if (newTask.acceptanceStatus == 'ACCP') {
        newAccptedTasks.add(newTask);
      } else {
        newTasks.add(newTask);
      }
    }
    tasks.value = newTasks;
    acceptedTasks.value = newAccptedTasks;
    update();
  }

  Future acceptTask(id) async {
    print(id);
    final response = await http.put(
      Uri.parse('$baseURL/drivers/acceptDeliveryRequest/$id'),
      headers: await authHeader(),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load vendor');
    }
  }

  Future rejectTask(id) async {
    print(id);
    final response = await http.put(
      Uri.parse('$baseURL/drivers/rejectDeliveryRequest/$id'),
      headers: await authHeader(),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load vendor');
    }
  }
}
