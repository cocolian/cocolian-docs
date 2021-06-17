---
layout: 	essay
title: 		"配置管理系统设计和选型"
subtitle: 	"支付系统设计"
date: 		2017-04-24 12:00:00
author: 	"shamphone"
chapter:	"8.2.4"
status:		"unfinished"
---

配置管理是每个系统中必不可少的一个组件，同时也往往是考察系统架构设计和程序员开发能力的一个重要方面。我们从当前配置管理实现机制演化来分析在支付系统以及微服务中应该如何对配置管理进行选型，以及如何选择合适的参数管理组件。 

## 配置文件



## 需求

1. 运营参数可以动态调整，无需重启 
2. 可以根据不同的stage、dc进行配置；
3. 数据库迁移，可以批量修改并重启。 
1、集中配置，所以的配置文件集中到一个管理平台来治理

2、配置中心修改配置后，可以及时推送到客户端

3、支持大的并发查询
4. 技术栈： java

## 本地文件

这应该是最常用，也是最稳定的配置信息管理方法。 在Springframework中，可以通过@PropertySource标注来注入配置信息
技术调研，配置中心目前有一些开源软件，如下：

1、Qihoo360/QConf

地址：https://github.com/Qihoo360/QConf

优点：成熟，支持百万并发 稳定

缺点：大型，稍显复杂；非java开发语言

2、spring-cloud/spring-cloud-config

地址： https://github.com/spring-cloud/spring-cloud-config

优点：借此学习了解 spring boot\spirng cloud

缺点：依赖于 spring boot；学习内容比较多

3、淘宝 diamond

https://github.com/takeseem/diamond

缺点：已经不维护，学习资料少

4、disconf

https://github.com/knightliao/disconf

优点：使用比较多，java开发

缺点：个人开源项目，也比较新