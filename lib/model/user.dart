class User {

  final String id;
  final String email;
  Map<int,Map<String, String>>? coursesTaken; //course id, status, when(sem)
  int? currentsem;
  final String studentId;

  User({
    required this.id,
    required this.email,
    required this.studentId,
    coursesTaken,
    currentsem,
  });

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'email': email,
      'coursesTaken': coursesTaken,
      'currentsem' : currentsem,
      'studentid' : studentId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String id){
    return User(
      id:map['id'],
      email: map['email'],
      coursesTaken: map['coursesTaken'],
      currentsem: map['currentsem'],
      studentId: map['studentid'],
    );
  }

}