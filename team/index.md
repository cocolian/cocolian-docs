---  
layout:     team   
title:      "管理感悟"  
date:       2019-02-19 12:00:00  
author:     "凤凰牌老熊"  
--- 

## 管理感悟

这里是老熊的管理经验的一些随笔，仅供参考。 

---

{% assign posts = site.categories['team'] | sort : "date" %}
{% for post in posts %}
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
{% endfor %}
