---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

## 自我介绍

## 浏览器缓存

### etag和last-modified谁的优先级高，etag有啥缺点

### 强缓存协商缓存的应用

## 跨域在平时开发怎么解决的

### 说了代理 nginx （还可以本地起服务来解决跨域，因为服务端之间没有跨域）

## rem怎么实现，需要怎么写代码从0实现

## webpack说一说

## 说一说事件循环

解释这道题

```js
async function async1 () {
  console.log('async1 start')
  await async2()
  console.log('async1 end')
}
async function async2 () {
  console.log('async2')
}

console.log('script start')
setTimeout(() => {
  console.log('setTimeout')
}, 0)
async1()
new Promise((reslove) => {
  console.log('promise1')
  reslove()
}).then(() => {
  console.log('promise2')
})
console.log('script end')
```

## 了解哪些优化

