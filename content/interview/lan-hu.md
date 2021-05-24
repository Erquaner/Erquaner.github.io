---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

### 自我介绍

### 问了项目

### 做编程题

请编写`function arrToObj(arr) {}`, 将

```js
const arr = [
  { node: "a", children: ["b", "c"] },
  { node: "d", children: ["a"] },
  { node: "b", children: ["e", "i"] },
  { node: "c", children: ["f"] },
  { node: "f", children: ["g"] },
  { node: "e", children: ["h"] }
]; 
```
变成
```js
const obj = {
  d: {
    a: {
      b: {
        e: {
          h: null
        },
        i: null
      },
      c: {
        f: {
          g: null
        }
      }
    }
  }
};
```
如果知道根节点呢 ，`function arrToObj(arr, root) {}`

[答案](https://codesandbox.io/s/lanhu-arr-to-obj-k7rxh)