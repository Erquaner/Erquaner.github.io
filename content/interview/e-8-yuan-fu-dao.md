---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

## 自我介绍


## 介绍项目

## ts

### 联合类型和交叉类型

```ts
interface A {
  foo: string;
  boo: number;
}
interface B {
  foo: string;
  car: number;
}

A & B =?
A|B = ?

interface B {
  foo: number;
  car: number;
}

A & B =?
A|B = ?

interface B extends A 和 A&B一样吗

```

### 实现一个Mutable 可以修改已读属性

```ts
interface A {
  readOnly foo: number
}
const a : Mutable<A> = {foo: 1}
a.foo = 2
```


## promise

### 说一说promise内部的状态转移

### 看输出，两种输出是否一样
```js
const p = new Promise((resolve, reject) => {
  resolve(0)
  console.log(1)
  reject(2)
})
p.then(res=> console.log(res)).catch(e => console.log(e))


p.then(res=> console.log(res))
p.catch(e => console.log(e))

```

## 说一说事件循环

微任务 ：1 2 3
宏任务 ：A B C

经历了几个循环都是哪几个


## 编程 

实现一个函数foo(list, limit) 一次发送的请求不超过limit个