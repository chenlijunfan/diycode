class UserBean {
  final int id; // 唯一 id
  final String login; // 登录用户名
  final String name; // 昵称
  final String avatar_url;

  UserBean(this.id, this.login, this.name, this.avatar_url); // 头像链接

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      json['id'],
      json['login'],
      json['name'],
      json['avatar_url'],
    );
  }
}



