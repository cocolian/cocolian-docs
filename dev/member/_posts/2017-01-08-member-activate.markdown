---
layout: member 
title: "激活账户"  
subtitle: "CIF-1001"  
date: 2017-01-08 20:00:00  
author: "shamphone"  
header-img: "img/home-bg-post.jpg"  
catalog: true  
chapter : "2.2"
tag: [api]  
---

## 接口定义

预开户状态用户进行支付密码信息设置，实现用户状态正常化。

```java
ActiveMembershipResponse activeMembership(ActiveMembershipRequest response);
```

## 输入参数 ActiveAccountRequest

|  名称                                                    | 属性         | 业务规则                                   |   备注       |
|----------------------------------------------------------|--------------|--------------------------------------------|--------------|
| 用户号                                                   | 可选         |                                            | 两者必输其一 |
| 用户标识                                                 | 可选         |                                            |
| 支付密码                                                 | 必选         |                                            |
| 短信验证码编号                                           | 可选         | 由短信验证码发送接口提供                   | 同时选输     |
| 短信验证码                                               | 可选         | 短信验证码在规定的时间段内且一次性验证有效 |

## 输出参数 ActiveAccountResponse

|  名称                                                    | 属性         | 业务规则                                   |   备注       |
|----------------------------------------------------------|--------------|--------------------------------------------|--------------|
| 执行结果                                                 | 必选         |                                            | 成功、失败   |
| 失败原因                                                 | 必选         |                                            |
| 用户号                                                   | 必选         |                                            |
| 用户状态                                                 | 必选         |                                            |

## 业务处理流程

1. 【会员系统】进行接口必输参数校验  
    - 【会员系统】进行**互联网支付密码**校验，如果不通过，则提示“接口输入参数缺失”异常（异常码：\$｛接口输入参数缺失｝）；  
    - 【会员系统】检查业务系统是否上送了**手机短信编号、手机短信验证码**，
        - 如果业务系统上送不完整，则提示“短信验证参数不完整”异常（异常码：\${短信验证参数不完整}）；
        - 如果同时上送了短信验证码编号、短信验证码，则进行短信验证码签权（*开户流程中只关注签权结果，具体签权过程由参见短信验证码签权的功能流程设计*），如果签权不通过，则将签权异常抛出。  
2. 【会员系统】进行业务校验  
    - 获取用户号  
        - 如果上送了**用户号**、未上送**用户标识**，可直接获取**用户号**；  
        - 如果上送了**用户标识**、未上送**用户号**，则先根据**用户标识**查询PER_个人用户标识表**[**PER_USER_LOGIN**]，**获取到**用户号**；  
    - 进行客户用户状态校验，【会员系统】通过公共组件确认要激活的用户状态是否正常，如果有客户关联则确认关联客户的状态是否正常，如果不正常，按公共组件抛出的异常进行抛出。
    - 确认要激活用户是否存在，通过**用户号**查询*个人用户基本信息表（用户标识字段）*，确认用户是否存在，如果不存在则提示“用户不存在”异常，（异常码：\$｛用户不存存在｝）；  
3. 【会员系统】进行用户激活：  
    - 进行**支付密码**的字段设置：设置*个人用户支付密码表*互联网登录密码字段；  
    - 修改用户状态从预开户状态为正常状态（1：正常，已激活），并记录激活时间到数据表中。  
4. 【会员系统】进行维护日志登记，调用相应工具进行系统维护日志表、系统维护日志明细表信息记录。
5. 【会员系统】登记系统事件登记表  
6. 【会员系统】发送短信通知  
    - 通过**用户号、标识类型**，查询**PER_个人用户登录标识**，获得手机号  
    - 通过业务获取短信模板，拼装短信内容
    - 调用短信发送接口，发送短信（短信发送失败不影响业务，接口中已实现重发机制）
7. 【会员系统】系统执行结果  
    - 如果失败，则返回失败原因  
    - 如果成功，则返回用户号、用户状态、  

【结束流程】

