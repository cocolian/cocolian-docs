---
layout: 	tax
title: 		"龚老师税法入门讲座系列"
date: 		2018-06-10 12:00:00
author: 	"龚晓冬"
chapter: 	"#"
---  

这一系列文章是龚晓冬老师在支付产品群里的分享整理而来。 
税法是支付人需要了解的基础知识。 

---

<ul class="post-list">
{% assign opages = site.pages | sort:"chapter" %}
{% for opage in opages %}
{% if opage.url contains '/tax/' and opage.url.size > 6 %}
<h2>{{ opage.chapter }}. <a href="{{ opage.url | prepend: site.baseurl }}">{{ opage.title }}</a></h2>
	<div class="post-content-preview">
		{{ opage.content | strip_html | truncate:200 }}
	</div>
	<ul>
{% assign cats = opage.url | split: '/' %}
{% if cats.size > 2  %}
{% assign cat = cats[2] %}
{% assign posts = site.categories[cat] | sort:"chapter" %}
{% for post in posts %}
{% if post.status != 'hidden'  %}
		<li>{{ opage.chapter }}.{{ post.chapter}}.  <a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
{% endif%}
	</ul>
{% endif%}
{% endfor %}