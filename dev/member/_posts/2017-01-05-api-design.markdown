---
layout: member 
title: "会员服务接口"  
date: 2017-01-05 20:00:00  
author: "shamphone"  
catalog: true  
chapter : "2"
tag: [api]  
---

```java

service MemberService {
	/**  
	 *  
	 * 创建会员  
	 *  
	 **/
	AddMemberResponse addMember(AddMemberRequest request)
	
	/**  
	 *  
	 * 激活会员  
	 *  
	 **/  
	ActiveMembershipResponse activeMembership(ActiveMembershipRequest response);
	
	/**  
	 *  
	 * 获取会员信息  
	 *  
	 **/  
	GetMemberResponse getMember(GetMemberRequest request);

};

```
