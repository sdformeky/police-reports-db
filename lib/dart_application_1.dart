import 'dart:io';

import "package:path/path.dart" as p;
import 'package:sqlite3/sqlite3.dart';

abstract class Identity {
  String get id;
}

class Client implements Identity {
  @override
  final String id;
  final String name;
  final String phone;

  Client({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone
  };

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map["id"] as String,
      name: map["name"] as String,
      phone: map["phone"] as String
    );
  }

  @override
  String toString() => "$name $phone";
}

class BeautyService implements Identity {
  @override
  final String id;
  final String name;
  final String title;
  final int price;
  final int durationMinutes;

  BeautyService({
    required this.id,
    required this.name,
    required this.title,
    required this.durationMinutes,
    required this.price
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "title": title,
    "price": price,
    "durationMinutes": durationMinutes
  };

  factory BeautyService.fromMap(Map<String, dynamic> map) {
    return BeautyService(
      id: map["id"] as String,
      name: map["name"] as String,
      title: map["title"] as String,
      price: map["price"] as int,
      durationMinutes: map["durationMinutes"] as int
    );
  }
}
class Appointment implements Identity {
  @override
  final String id;
  final String clientId;
  final String serviceId;
  final DateTime time;

  Appointment({
    required this.id,
    required this.clientId,
    required this.serviceId,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "client_id": clientId,
    "serviceId": serviceId,
    "time": time.toIso8601String(),
  };

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map["id"] as String,
      clientId: map["client_id"] as String,
      serviceId: map["serviceId"] as String,
      time: DateTime.parse(map["time"] as String),
    );
  }

  @override
  String toString() => "Appointment(id: $id, clientId: $clientId, serviceId: $serviceId, time: $time)";
}
  class SalonDatabase {
    final Database sqlite;
    
    SalonDatabase._(this.sqlite);
    
    static SalonDatabase open({String dataDir = "data"}) {
      Directory(dataDir).createSync(recursive: true);
      final filePath = p.join(dataDir, "LibraryDart");
      return SalonDatabase._(sqlite3.open(filePath));
    }
    
    void createTables() {
      
      sqlite.execute("""
        CREATE TABLE IF NOT EXISTS clients(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          phone TEXT NOT NULL
        )
      """);
      
    
      sqlite.execute("""
        CREATE TABLE IF NOT EXISTS services(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          title TEXT NOT NULL,
          price INTEGER NOT NULL,
          durationMinutes INTEGER NOT NULL
        )
      """);
      
    
      sqlite.execute("""
        CREATE TABLE IF NOT EXISTS appointments(
          id TEXT PRIMARY KEY,
          client_id TEXT NOT NULL,
          serviceId TEXT NOT NULL,
          time DATETIME NOT NULL,
          FOREIGN KEY (client_id) REFERENCES clients(id),
          FOREIGN KEY (serviceId) REFERENCES services(id)
        )
      """);
    }
    
    void insertClient(Client client) {
      sqlite.execute(
        'INSERT OR REPLACE INTO clients(id, name, phone) VALUES(?, ?, ?)',
        [client.id, client.name, client.phone]
      );
    }
    

  List<Client> getAllClients(){
    final result=sqlite.select('SELECT * FROM clients');
    return result.map((row)=> Client.fromMap((row))).toList();
  }
  
  Client? getClient(String id) {
    final result = sqlite.select('SELECT * FROM clients WHERE id=?', [id]);
    return result.isNotEmpty ? Client.fromMap(result.first) : null;
}

void updateClient(Client client) {
    sqlite.execute('UPDATE clients SET name=?, phone=? WHERE id=?', [client.name, client.phone, client.id]);
}

void deleteClient(String id) {
    sqlite.execute('DELETE FROM clients WHERE id=?', [id]);
}
void insertService(BeautyService service) {
    sqlite.execute(
        'INSERT OR REPLACE INTO services(id, name, title, price, durationMinutes) VALUES(?, ?, ?, ?, ?)',
        [service.id, service.name, service.title, service.price, service.durationMinutes]
    );
}

List<BeautyService> getAllServices() {
    final result = sqlite.select('SELECT * FROM services');
    return result.map((row) => BeautyService.fromMap(row)).toList();
}

BeautyService? getService(String id) {
    final result = sqlite.select('SELECT * FROM services WHERE id=?', [id]);
    return result.isNotEmpty ? BeautyService.fromMap(result.first) : null;
}

void updateService(BeautyService service) {
    sqlite.execute(
        'UPDATE services SET name=?, title=?, price=?, durationMinutes=? WHERE id=?',
        [service.name, service.title, service.price, service.durationMinutes, service.id]
    );
}

void deleteService(String id) {
    sqlite.execute('DELETE FROM services WHERE id=?', [id]);
} 
void insertApp(Appointment app) {
    sqlite.execute(
        'INSERT OR REPLACE INTO appointments(id, client_id, serviceId, time) VALUES(?, ?, ?, ?)',
        [app.id, app.clientId, app.serviceId, app.time.toIso8601String()]
    );
}

List<Appointment> getAllApp() {
    final result = sqlite.select('SELECT * FROM appointments');
    return result.map((row) => Appointment.fromMap(row)).toList();
}

Appointment? getAppByClientId(String clientId) {
    final result = sqlite.select('SELECT * FROM appointments WHERE client_id=?', [clientId]);
    return result.isNotEmpty ? Appointment.fromMap(result.first) : null;
}

List<Appointment> getAllAppsByClientId(String clientId) {
    final result = sqlite.select('SELECT * FROM appointments WHERE client_id=?', [clientId]);
    return result.map((row) => Appointment.fromMap(row)).toList();
}

void updateApp(Appointment app) {
    sqlite.execute(
        'UPDATE appointments SET client_id=?, serviceId=?, time=? WHERE id=?',
        [app.clientId, app.serviceId, app.time.toIso8601String(), app.id]
    );
}

void deleteApp(String id) {
    sqlite.execute('DELETE FROM appointments WHERE id=?', [id]);
}
void dispose(){
  sqlite.dispose();

}
} 