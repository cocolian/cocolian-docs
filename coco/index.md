---
layout: 	coco
title: 		"区块链开发指南"
subtitle: 	"区块链相关"
date: 		2018-06-10 12:00:00
author: 	"凤凰牌老熊"
chapter:	"#"
---  

Solidity是用来在以太坊上开发合约的官方语言， 了解一些区块链和以太坊的基础知识，有利于快速掌握这一门语言。 
虽然现在有不少Solidity中文文档，要么翻译得差，要么版本太老了。 这里我们将结合以太坊的官方文档，开发一套solidity语言指南。 
官方文档在github上， 有推荐的中文翻译，但翻译的极烂，很多地方甚至都翻译错了，不建议看。 

<ul class="post-list">
{% assign opages = site.pages | sort:"chapter" %}
{% for opage in opages %}
{% if opage.url contains '/coco/' and opage.url.size > 7 %}
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