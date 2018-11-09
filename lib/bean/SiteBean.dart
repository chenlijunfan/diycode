class SiteListBean {
  List<SiteBean> fromJson(List<dynamic> datas) {
    List<SiteBean> result = <SiteBean>[];
    for (int i = 0; i < datas.length; i++) {
      SiteBean newsBean = new SiteBean.fromJson(datas[i]);
      result.add(newsBean);
    }
    return result;
  }
}

class SiteBean {
  final int id; // 唯一 id
  final String name; // 类别
  final List<SiteDetaiBean> sites;

  SiteBean(this.id, this.name, this.sites);

  SiteBean.fromJson(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        sites = new SiteDetailListBean().fromJson(data["sites"]);
}

class SiteDetailListBean {
  List<SiteDetaiBean> fromJson(List<dynamic> datas) {
    List<SiteDetaiBean> result = <SiteDetaiBean>[];
    for (int i = 0; i < datas.length; i++) {
      SiteDetaiBean newsBean = new SiteDetaiBean.fromJson(datas[i]);
      result.add(newsBean);
    }
    return result;
  }
}

class SiteDetaiBean {
  final String name;
  final String url;
  final String avatar_url;

  SiteDetaiBean(this.name, this.url, this.avatar_url);

  SiteDetaiBean.fromJson(Map<String, dynamic> data)
      : name = data["name"],
        url = data["url"],
        avatar_url = data["avatar_url"];
}
