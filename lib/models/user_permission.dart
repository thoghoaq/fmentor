class UserPermission {
  int isMentor;
  int canSeeSettings;
  int canSeePolicy;
  int canLogout;
  int canFollowMentors;
  int canRequestToMentor;
  int canMakeSchedule;
  int canSeeCourses;

  UserPermission({
    required this.isMentor,
    required this.canSeeSettings,
    required this.canSeePolicy,
    required this.canLogout,
    required this.canFollowMentors,
    required this.canRequestToMentor,
    required this.canMakeSchedule,
    required this.canSeeCourses,
  });

  factory UserPermission.fromJson(dynamic json) {
    return UserPermission(
      isMentor: json['isMentor'],
      canSeeSettings: json['canSeeSettings'],
      canSeePolicy: json['canSeePolicy'],
      canLogout: json['canLogout'],
      canFollowMentors: json['canFollowMentors'],
      canRequestToMentor: json['canRequestToMentor'],
      canMakeSchedule: json['canMakeSchedule'],
      canSeeCourses: json['canSeeCourses'],
    );
  }
}
