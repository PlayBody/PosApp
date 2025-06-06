import 'package:staff_pos_app/src/http/webservice.dart';
import 'package:staff_pos_app/src/model/groupmodel.dart';

import '../apiendpoint.dart';

class ClGroup {
  Future<List<GroupModel>> loadGroupList(context, String companyId) async {
    Map<dynamic, dynamic> results = {};
    print('--------------------');
    print(companyId);
    await Webservice().loadHttp(context, apiLoadGroups,
        {'company_id': companyId}).then((v) => {results = v});
    List<GroupModel> groups = [];
    if (results['is_result']) {
      for (var item in results['data']) {
        groups.add(GroupModel.fromJson(item));
      }
    }

    return groups;
  }

  Future<bool> deleteGroup(context, String groupId) async {
    String apiUrl = '$apiBase/apigroups/deleteGroup';

    Map<dynamic, dynamic> results = {};
    await Webservice().loadHttp(
        context, apiUrl, {'group_id': groupId}).then((v) => {results = v});

    return results['isDelete'];
  }
}
