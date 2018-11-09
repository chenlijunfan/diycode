import 'package:diycode/bean/UserBean.dart';

class NewsListBean {
  List<NewsBean> fromJson(List<dynamic> datas) {
    List<NewsBean> result = <NewsBean>[];
    for (int i = 0; i < datas.length; i++) {
      NewsBean newsBean = new NewsBean.fromJson(datas[i]);
      result.add(newsBean);
    }
    return result;
  }
}

class NewsBean {
  final int id; // 唯一 id
  final String title; // 标题
  final String created_at; // 创建时间
  final String updated_at; // 更新时间
  final UserBean user; // 创建该话题的用户(信息)
  final String node_name; // 节点名称
  final int node_id; // 节点 id
  final int last_reply_user_id; // 最近一次回复的用户 id
  final String last_reply_user_login; // 最近一次回复的用户登录名
  final String replied_at; // 最近一次回复时间
  final int replies_count; // 回复总数量
  final String address; // 具体地址

  NewsBean(
      this.id,
      this.title,
      this.created_at,
      this.updated_at,
      this.user,
      this.node_name,
      this.node_id,
      this.last_reply_user_id,
      this.last_reply_user_login,
      this.replied_at,
      this.replies_count,
      this.address);

  NewsBean.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        created_at = json['created_at'],
        updated_at = json['updated_at'],
        user = new UserBean.fromJson(json['user']),
        node_name = json['node_name'],
        node_id = json['node_id'],
        last_reply_user_id = json['last_reply_user_id'],
        last_reply_user_login = json['last_reply_user_login'],
        replied_at = json['replied_at'],
        replies_count = json['replies_count'],
        address = json['address'];
}
