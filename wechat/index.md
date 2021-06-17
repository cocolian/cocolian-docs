---  
layout:     post   
title:      "支付领域交流微信群"  
date:       2018-08-19 12:00:00  
author:     "支付产品开发群"  
tag:		[publish] 
--- 

## 加入支付领域交流微信群

目前有四个支付产品和技术交流的微信群，几乎每天都有支付相关的内容分享。和支付相关的问题在群里能够很快找到解决方案。如果您是支付或者金融领域的产品经理、资深工程师等技术、管理人员，欢迎加入我们。 

- 请查看[入群协议](http://doc.cocolian.cn/wechat/group/2018/01/01/proposal/)   
- 入群条件以及分享安排事宜，请查看[入群问答](http://doc.cocolian.cn/wechat/group/2018/01/02/qa/)  

如果认可以上原则，请扫码关注“凤凰牌老熊”公众号， 并留言**加入支付产品群**，群管理同学会尽快联系你。 
![群二维码](http://static.cocolian.cn/img/reward/weixin.jpg)

---

{% assign posts = site.categories['wechat'] | sort : "date" | reverse %}
{% for post in posts limit:10 %}
	{% assign  display = false  %}
		{% for tag in post.tags %}
			{% if tag == "publish"  %} {% assign display = true %}  {%endif %}
		{% endfor %}
	{% if display %}
<div class="post-preview">
    <a href="{{ post.url | prepend: site.baseurl }}">
        <h2 class="post-title">
            {{ post.title }}
        </h2>
        {% if post.subtitle %}
        <h3 class="post-subtitle">
            {{ post.subtitle }}
        </h3>
        {% endif %}
        <div class="post-content-preview">
            {{ post.content | strip_html | truncate:200 }}
        </div>
    </a>
</div>
<hr/>
	{% endif %}
{% endfor %}
