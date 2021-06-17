---  
layout:     post   
title:      "20181129-支付系统的单元测试"  
date:       2018-11-29 12:00:00  
author:     "支付产品开发群"  
tag:		[publish] 
---

今天我分享spring+powermock+h2单元测试。因为网上这样的东西不多，我们公司正好用这个，所以分享一下。我把[demo](https://github.com/hgc19890423/mock)放到了github上；

## 一：什么是powermock

powerMock测试解决的是隔离外部接口对自己项目的影响,比如项目依赖别的项目的接口，或者数据库，powerMock可以自由操作这些依赖，防止外部对自己的影响，让我们做好自己的事情就好。  
在Java领域已经有如此多的Mock框架，比如EasyMock，JMock，Mockito ；为什么还要有PowerMock的存在，上述三个已经有重复发明轮子的嫌疑， 为什么还要大 家去使用 PowerMock 呢？   
其实 PowerMock 并不是重发发明轮子，他的出现只是为了解决上述三种框架根本没有办法完成的工作， 比如 Mock 一个 Static 方法等等，更多的将PowerMock理解为对现有Mock框架的扩展和进一步封装是比较贴切的。  
我采用的是spring+PowerMock+h2这样的组合来进行测试的。

## 二：什么是H2 

H2就是内存数据库，项目中加一个jar包就可以使用了，支持mysql.用了它，真实环境的mysql就可以不用了。


## 三：环境搭建 

加测试的jar包，包括，spring-test,junit,dbjunit,powermock,spring-test-dbjunit,h2,具体看项目中的pom构建spring的测试环境，主要是spring.h2db.xml,h2.properties配置文件，在spring.h2db.xml中需要建表的sql。创建BaseTest,这里主要是初始化spring，还有powerMock(在setUp里)。

## 四：具体的使用 

具体的使用在项目中，说一下注意的地方：
- 建表语句要删除了一些mysql中特有的东西，比如innodb，编码格式等。否则初始化会报错powermock文件夹下是根据PowerMock.pdf写的。
- 一共有十种使用情况。我把有些地方换成了注解的形式service文件夹是我根据我在工作中遇到的几种情况，其中主要是和spring整合，解决了多层调用mock的问题根目录下的sql文件夹是项目中用到的sql,doc文件夹下是Power.pdf,建议照着pdf去看代码  

![image](http://static.cocolian.cn/img/20181129_201351.png)  
![image](http://static.cocolian.cn/img/20181129_201441.png)  
这里是powermock与spring整合之后，有多层调用的问题，用这种方式可以注入解决   
![image](http://static.cocolian.cn/img/20181129_201659.png)  

这是h2的使用

- 这是h2的建表语句，注意 ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT=&#39;图书信息表&#39;这部分删掉，否则会报错。
![image](http://static.cocolian.cn/img/20181129_202216.png)

# Q&A

**Q:** powermock好像一般也是和mockito一起用吧，一般是mock static的method？对么？  

**A:** powermockjar包里有mocktio。  
