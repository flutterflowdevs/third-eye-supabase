import '../database.dart';

class ChatTable extends SupabaseTable<ChatRow> {
  @override
  String get tableName => 'chat';

  @override
  ChatRow createRow(Map<String, dynamic> data) => ChatRow(data);
}

class ChatRow extends SupabaseDataRow {
  ChatRow(super.data);

  @override
  SupabaseTable get table => ChatTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get chatId => getField<int>('chat_id');
  set chatId(int? value) => setField<int>('chat_id', value);

  int? get msgId => getField<int>('msg_id');
  set msgId(int? value) => setField<int>('msg_id', value);

  String? get userId1 => getField<String>('user_id_1');
  set userId1(String? value) => setField<String>('user_id_1', value);

  String? get userId2 => getField<String>('user_id_2');
  set userId2(String? value) => setField<String>('user_id_2', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get chatPerson => getField<String>('chat_person');
  set chatPerson(String? value) => setField<String>('chat_person', value);
}
