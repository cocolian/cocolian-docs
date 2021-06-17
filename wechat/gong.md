---  
layout:     post   
title:      "龚老师专题"  
date:       2018-08-19 12:00:00  
author:     "支付产品开发群"  
--- 

{% assign posts = site.categories['wechat'] | sort : "date" | reverse %}
{% for post in posts %}
	{% assign  display = false  %}
		{% for tag in post.tags %}
			{% if tag == "gong"  %} {% assign display = true %}  {%endif %}
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
