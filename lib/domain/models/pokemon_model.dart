class Pokemon {
  final int id;
  final String name;
  final String sprite;
  final List<StatElement> stats;
  final List<Type> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprite,
    required this.stats,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: json["name"],
        sprite: json["sprites"]['other']['home']['front_default'],
        stats: List<StatElement>.from(
          json["stats"].map(
            (x) => StatElement.fromJson(x),
          ),
        ),
        types: List<Type>.from(
          json["types"].map(
            (x) => Type.fromJson(x),
          ),
        ),
      );

  factory Pokemon.fromLocalJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: json["name"],
        sprite: json["sprite"],
        stats: List<StatElement>.from(
          json["stats"].map(
            (x) => StatElement.fromLocalJson(x),
          ),
        ),
        types: List<Type>.from(
          json["types"].map(
            (x) => Type.fromLocalJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprite': sprite,
      'stats': stats.map((e) => e.toJson()).toList(),
      'types': types.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'PokemonData(id: $id, name: $name, sprite: $sprite, stats: $stats, types: $types)';
  }
}

class StatElement {
  final int baseStat;
  final String statName;

  StatElement({
    required this.baseStat,
    required this.statName,
  });

  factory StatElement.fromJson(Map<String, dynamic> json) => StatElement(
        baseStat: json["base_stat"],
        statName: json["stat"]['name'],
      );

  factory StatElement.fromLocalJson(Map<String, dynamic> json) => StatElement(
        baseStat: json["baseStat"],
        statName: json["statName"],
      );

  Map<String, dynamic> toJson() {
    return {
      'baseStat': baseStat,
      'statName': statName,
    };
  }

  @override
  String toString() {
    return 'statName: $statName, baseStat: $baseStat';
  }
}

class Type {
  final int slot;
  final String typeName;

  Type({
    required this.slot,
    required this.typeName,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        typeName: json["type"]["name"],
      );

  factory Type.fromLocalJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        typeName: json["typeName"],
      );

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'typeName': typeName,
    };
  }

  @override
  String toString() {
    return 'Type(slot: $slot, typeName: $typeName)';
  }
}
