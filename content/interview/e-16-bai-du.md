---
title: ""
date: 2021-05-20T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---


## 一面

### 自我介绍


### 切换主题

### h5兼容性问题

- 1px是因为什么
- 怎么解决
- 除了放大缩小

### 移动端怎么调试

- 如果出现了线上某一机型有问题，怎么调试

### 图片不知道宽高怎么预加载不会出现样式抖动

### es6 新特性

- promise.allsettled
- async await 和 promise有什么区别
  
### 现有的路由模式

### 事件循环

```js
const p = new Promise((resolve, reject) => {
    console.log(2);
    resolve();
    console.log('hello')
});

console.log(3);


setTimeout(() => {
    console.log(4)
}, 1000)

p.then(() => {
    console.log(5);
});

setTimeout(() => {
    console.log(6)
}, 0)

console.log(7);
```

### css看样式

```html
<style type="text/css">
  .c1 .c2 div{  
    color: blue;
  }
  div #box3{
    color:green;
  }
  #box1 div{
    color:yellow;
  }
</style>
</head>
<body>
<div id="box1" class="c1">
  <div id="box2" class="c2">
    <div id="box3" class="c3">
      文字
    </div>
  </div>
</div>
</body>
```

### 判断是否是回文数 用多种方法


### 数组转树形结构

```js

// 将父子接口的数据转化成树形结构的数据
// 将一纬数组处理为树结构？
var data=[
 { id: 0, parentId: null, note: “一级菜单-1” },
{ id: 40, parentId: 0, note: “一级菜单-1” },
{ id: 20, parentId: 0, note: “一级菜单-2” },
{ id: 22, parentId: 20, note: “二级菜单-22” },
{ id: 24, parentId: 22, note: “三级菜单-24” },
{ id: 34, parentId: 22, note: “三级菜单-34” }
];

[{
	 id: 40, parentId: 0, note: “一级菜单-1”,
  children: []
}, {{
    id: 20, parentId: 0, note: “一级菜单-2”,
    children: [
      {
        id: 22, parentId: 20, note: “二级菜单-22”,
      children: [
          { id: 24, parentId: 22, note: “三级菜单-24” },
          { id: 34, parentId: 22, note: “三级菜单-34” }
        ]
     }
    ]
}}

```