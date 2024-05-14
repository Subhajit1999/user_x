class User {
    String gender;
    Name name;
    Dob dob;
    String phone;
    String cell;
    String picture;

    User({
        required this.gender,
        required this.name,
        required this.dob,
        required this.phone,
        required this.cell,
        required this.picture,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json["gender"],
        name: Name.fromJson(json["name"]),
        dob: Dob.fromJson(json["dob"]),
        phone: json["phone"],
        cell: json["cell"],
        picture: json["picture"].runtimeType == String? json["picture"] : json["picture"]['large'],
    );

    Map<String, dynamic> toJson() => {
        "gender": gender,
        "name": name.toJson(),
        "dob": dob.toJson(),
        "phone": phone,
        "cell": cell,
        "picture": picture,
    };
}

class Dob {
    DateTime date;
    int age;

    Dob({
        required this.date,
        required this.age,
    });

    factory Dob.fromJson(Map<String, dynamic> json) => Dob(
        date: DateTime.parse(json["date"]),
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "age": age,
    };
}

class Name {
    String title;
    String first;
    String last;

    Name({
        required this.title,
        required this.first,
        required this.last,
    });

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json["title"],
        first: json["first"],
        last: json["last"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "first": first,
        "last": last,
    };
}
