---  
layout:     egov   
title:      "数字政府"  
date:       2024-06-01 09:00:00
author:     "凤凰牌老熊"  
--- 

## 数字政府


{% assign posts = site.categories['egov']  %}
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
