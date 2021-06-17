---
layout: 	essay
title: 		"支付系统设计"
subtitle: 	"基于微服务的支付系统设计"
date: 		2018-06-10 12:00:00
author: 	"凤凰牌老熊"
chapter: 	"#"
---  

这一系列文章是本人在多个公司中从事支付系统建设的总结。 此外， 老熊本人组织和维护的支付产品技术交流微信群，也帮助完善了这些文章的内容。 
就支付系统而言，目前市面上缺乏实操性强的书籍和文章。这也是可以理解的，大部分公司的支付系统，涉及到资金问题，对安全性要求都非常高。 
所以，公司一般采取禁止对外交流的方式来阻止意外的信息泄露。 这也为这个领域的发展带来一定的障碍。 

这些文章，是在现有工作基础上的总结，但不涉及到实际的业务内容。 重点在探讨如何建设一个符合实际需要的支付系统。 
注意： 每个公司的情况不一样，因而支付系统的具体实现，比如划分哪些模块，也是不一样的。 
这系列文章重点在帮助技术人员梳理支付系统在设计上的思路，比如如何按照业务来划分模块，每个功能模块设计时需要考虑什么问题。 

---

<ul class="post-list">
{% assign opages = site.pages | sort:"chapter" %}
{% for opage in opages %}
{% if opage.url contains '/essay/' and opage.url.size > 8 %}
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