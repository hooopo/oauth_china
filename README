#简介：

    OAuth gem for rails，支持豆瓣，新浪微薄，腾讯微博，搜狐微博，网易微博

#安装：

    $ gem install oauth_china

#使用：

    1. 在Gemfile里添加:

        gem 'oauth_china'

    2. 添加配置文件

        config/oauth/douban.yml
        config/oauth/sina.yml
        config/oauth/qq.yml

        配置文件格式：
            development:
              key:    "you api key"
              secret: "your secret"
              url:    "http://yoursite.com"
              callback: "http://localhost:3000/your_callback_url"
            production:
              key:    "you api key"
              secret: "your secret"
              url:    "http://yoursite.com"
              callback: "http://localhost:3000/your_callback_url"

    3.演示[TODO]
    4.注意
       系统时间要正确设置。否则会出现timstamps refused错误

#API文档
    腾讯微博API文档：http://open.t.qq.com/resource.php?i=1,1
    新浪微博API文档：http://open.t.sina.com.cn/wiki/index.php/API%E6%96%87%E6%A1%A3
    豆瓣微博API文档：http://www.douban.com/service/apidoc/reference/