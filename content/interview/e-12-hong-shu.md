---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

### 自我介绍

### css三栏布局

### 单行文本、多行文本溢出通用方案

- 说了line-climp
- 那可能有浏览器兼容的限制
- 又说了js
- 那不用js 纯css解决呢

### 画一个三角形

- 宽高必须要设置吗

### 怎么使用小图片

- 说了base 64 
- 那大图问什么不用base64
- 那小图打包和用base64之后文件大小有什么区别吗

### 写一个debounce

```js
function debounce(fn, timeout) {
  let timer = null;

  return function () {
    const context = this;

    clearTimeout(timer);

    timer = setTimeout(() => {
      clearTimeout(timer);
      fn.apply(context, arguments);
    }, timeout);
  };
}
```
- 为什么清除了两次timer
- settimeout计时不准确怎么解决
- 说和服务器校准时间
- 还有什么方法可以解决的
- apply内部实现
  
### react什么时候会触发渲染

- props改变不想子组件渲染
- 说了shouldComponentUpdate
- 还有其他方式吗

### 每次setState都会渲染吗

- 说了同步异步的合并setState
- 这是react自己的机制吗？我说了是。。。
- 为什么react要这样处理

### 跨域

- 浏览器什么时候处理的跨域
- 为什么要有跨域
- 401 、403、400、302状态码含义
  
### 浏览器缓存

### 编程 

```js
const obj = {
  name: 'a',
  children: [
    { 
      name: 'b',
      children: [{
        name: 'c',
        children: [{name: 'd', children: null}]
      },
      {
        name: 'e',
        children: [{name: 'f', children: null}]
      }]
    },
    {
        name: 'g',
        children: [{name: 'h', children: null}]
    }]
}
```
遍历一下这个obj 输出name

- 写了深度遍历
- 还让写广度遍历