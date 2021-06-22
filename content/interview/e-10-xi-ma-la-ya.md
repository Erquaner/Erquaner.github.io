---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

### 自我介绍

### 基本情况

### 服务端渲染

#### 和客户端对比优缺点

#### 怎么判断客户端渲染到服务端渲染的优化提速多少，看什么指标

#### qps多少？高并发怎么办？

#### 了解服务端渲染的基本指标吗？

### 编程题

找到一个字符串里不重复的字符并返回它，没找到返回-1
例： akasbjjjee返回k

```js
function findOnceStr(str) {
  let map = new Map()
  for (let i = 0; i < str.length; i++) {
      map.set(str[i],map.has(str[i]) )
  }

  for (let j of map.keys()) {
    console.log(map.get(j), '===')
    if(map.get(j) === false)   return j
  }
  return -1
}
console.log(findOnceStr('111abaacd'))
```

### 浏览器的cookie和localstorage的区别

#### localstorage不主动清除不会失效？那cookie有效时间是多少？是会话级的吗？

#### 怎么删除cookie 

#### cookie多大？localstorage多大？

### 水平居中不定宽元素的方法

- 父级flex定位
- `absolute` + `transform`
- `diplay: inline` + `text-align: center`

### 防抖和节流的区别以及应用场景

### 重绘重排区别，怎么避免

### react diff算法



