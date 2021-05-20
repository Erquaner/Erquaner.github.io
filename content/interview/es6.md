---
title: "es6"
date: 2021-05-01T16:25:20+08:00
draft: false
hiddenFromHomePage: true
tags: ["es6"]
toc: true
---

## proxy

### 概念

Proxy 对象用于创建一个对象的代理，实现基本操作的拦截和自定义。即在访问对象之前建立一道“拦截”，任何访问该对象的操作之前都必须通过这道“拦截”(即执行Proxy里面定义的方法)，起到一定的过滤作用。

### 方法

```js
let pro = new Proxy(target,handler);
```

{{% admonition type="info" title="1.get(target, propKey, receiver)" details="true" %}}

- 用于拦截某个属性的读取操作，接受三个参数：
target(目标对象)、propKey(属性名)、receiver?(Proxy或者继承Proxy的对象)

- 会拦截这些操作：`proxy[foo]`, `proxy.bar`, `Object.create(proxy)[foo]`, `Reflect.get()`


- 示例

```js
let obj = {};
Object.defineProperty(obj, "a", {
  configurable: false,
  enumerable: false,
  value: 10,
  writable: false
});

let p = new Proxy(obj, {
  get: function(target, prop) {
    return 20;
  }
});

p.a; //会抛出TypeError
```

{{% /admonition %}}


{{% admonition type="info" title="2.set" details="true" %}}


- 会拦截这些操作`proxy[foo]=xxx`,`proxy.foo = bar`, `Object.create(proxy)[foo] = bar`, `Reflect.set()`


- 返回值为true，则修改成功；为false则不可修改，严格模式下，会抛出TypeError
  
- 示例
```js
let p = new Proxy({}, {
  set: function(target, prop, value, receiver) {
    target[prop] = value;
    console.log('property set: ' + prop + ' = ' + value);
    return true;
  }
})

console.log('a' in p);  // false

p.a = 10;               // "property set: a = 10"
console.log('a' in p);  // true
console.log(p.a);       // 10
```
{{% /admonition %}}



## reflect 

### 概念

Reflect 是一个内置的对象，它提供拦截 JavaScript 操作的方法。这些方法与proxy handlers的方法相同。Reflect不是一个函数对象，因此它是不可构造的。

### 方法

Reflect对象一共有 13 个静态方法（匹配Proxy的13种拦截行为）。



## [其他新特性](https://github.com/coffe1891/frontend-hard-mode-interview/blob/master/1/1.1.1.md)


## 参考文章

[Proxy](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Proxy)

[Reflect](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Reflect)
