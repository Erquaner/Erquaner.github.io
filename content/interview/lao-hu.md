---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

### 自我介绍

## html语义化的优点？

### 你用过的语义化标签

## 前端有哪些存储方式

### cookie存储在哪？怎么应用？

## css bfc

## 重绘重排

### 怎么样减少重排

## css怎么样让一个元素不显示

## 节流防抖

### 日常在什么情境下应用了

## 闭包

### 有哪些应用

## 常用的es6

## 作用域

## csrf

## 编程题

写一个函数依次循环打印1 2 1 2

```js
foo() //1
foo() //2
foo() //1
foo() //2
```

```js
function printFoo() {
  let count = 1;
  return function () {
    console.log(count%2 ===0? 2: 1)
    count++
  }
}
const foo = printFoo()
foo()
foo()
foo()
foo()
```