---
layout: 	coco
title: 		"可可链草稿"
subtitle: 	"区块链相关"
date: 		2018-06-10 12:00:00
author: 	"凤凰牌老熊"
chapter:	"0"
---  


<ul class="post-list">
{% assign opages = site.pages | sort:"chapter" %}
{% for opage in opages %}
{% if opage.url contains '/coco/' %}
<li>{{ opage.chapter }}. <a href="{{ opage.url | prepend: site.baseurl }}">{{ opage.title }}</a></li>
{% assign cats = opage.url | split: '/' %}
{% if cats.size > 2  %}
{% assign cat = cats[2] %}
{% assign posts = site.categories[cat] | sort:"chapter" %}
{% for post in posts %}

<li>{{ opage.chapter }}.{{ post.chapter}}.  <a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></li>

{% endfor %}
{% endif%}
{% endif%}
{% endfor %}
</ul>