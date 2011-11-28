#简介

* 通过OAuth方式同步用户消息到微博平台（支持豆瓣，新浪微薄，腾讯微博，搜狐微博，网易微博）
* 和omini-auth的区别：omini-auth是专门提供oauth授权和获取用户信息的gem(比如用新浪微博帐号登陆这种需求)
* oauth_china是一个方便的同步信息到其他微博平台的gem（用来做像follow5.com或http://fanfou.com/settings/sync这样需求）
    
#安装

``````
gem install oauth_china
``````

#使用

* 在Gemfile里添加:

``````
gem 'oauth'
gem 'oauth_china'
``````

*  添加配置文件

``````
config/oauth/douban.yml
config/oauth/sina.yml
config/oauth/qq.yml
config/oauth/sohu.yml
config/oauth/netease.yml
``````

*  配置文件格式：
        
``````yaml
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
``````

*  演示

``````ruby
#config/routes.rb
match "syncs/:type/new" => "syncs#new", :as => :sync_new
match "syncs/:type/callback" => "syncs#callback", :as => :sync_callback

# encoding: UTF-8
class SyncsController < ApplicationController

  def new
    client = OauthChina::Sina.new
    authorize_url = client.authorize_url
    Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)
    redirect_to authorize_url
  end

  def callback
    client = OauthChina::Sina.load(Rails.cache.read(build_oauth_token_key(params[:type], params[:oauth_token])))
    client.authorize(:oauth_verifier => params[:oauth_verifier])

    results = client.dump

    if results[:access_token] && results[:access_token_secret]
      #在这里把access token and access token secret存到db
      #下次使用的时候:
      #client = OauthChina::Sina.load(:access_token => "xx", :access_token_secret => "xxx")
      #client.add_status("同步到新浪微薄..")
      flash[:notice] = "授权成功！"
    else
      flash[:notice] = "授权失败!"
    end
    redirect_to root_path
  end

  private
  def build_oauth_token_key(name, oauth_token)
    [name, oauth_token].join("_")
  end
end
``````

*  注意

系统时间要正确设置。否则会出现timstamps refused错误

#API文档

* 腾讯微博API文档：http://open.t.qq.com/resource.php?i=1,1
* 新浪微博API文档：http://open.t.sina.com.cn/wiki/index.php/API%E6%96%87%E6%A1%A3
* 豆瓣微博API文档：http://www.douban.com/service/apidoc/reference/

#License
  This program is free softwareyou can redistribute it and /or modify
  it under the terms of the GNU General Public License as published by 
  the Free Software Foundataioneither version 2 of the License,or (at 
  your option) any later version.

  You should have read the GNU General Public License before start "RTFSC".

  If not,see <http://www.gnu.org/licenses/>
