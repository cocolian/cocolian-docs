---
layout: 	source
title: 		"已整理的记录"
author: 	"群管理"
date:       2018-02-26 12:00:00 
categories:	['source','management']
---


{% assign posts = site.categories['wechat'] | sort : "date" | reverse %}
  
|  群  |   公开  | 标题  |
|------|----------|------|  
{% for post in posts%}| {{ post.author }} &nbsp;&nbsp; | {% for tag in post.tags %}{% if tag == "hidden" %}<i class="icon-key"></i> {%endif %}	{% endfor %} |  [{{ post.title }}]({{ post.url | prepend: site.baseurl }}) | 	   
{% endfor %}
