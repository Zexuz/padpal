import 'package:get_it/get_it.dart';

import 'services/message_list_tile_data_service.dart';

void setupServiceLocator() {
  GetIt.I.registerSingleton<MessageListTileDataService>(MessageListTileDataService());
}
