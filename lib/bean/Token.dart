class Token {
  final String access_token; // 用户令牌(获取相关数据使用)
  final String token_type; // 令牌类型
  final int expires_in; // 过期时间
  final String refresh_token; // 刷新令牌(获取新的令牌)
  final int created_at;

  Token(this.access_token, this.token_type, this.expires_in, this.refresh_token,
      this.created_at); // 创建时间

  factory Token.fromJson(Map<String, dynamic> json) {
    return new Token(json["access_token"], json['token_type'],
        json['expires_in'], json['refresh_token'], json['created_at']);
  }
}
