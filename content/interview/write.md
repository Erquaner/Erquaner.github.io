---
title: "手写代码"
date: 2021-05-01T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---


## promise

- Promise就是为了解决回调地狱的问题而产生的。
- 特点 
    - Promise 本质是一个状态机，每个 Promise 有三种状态：pending、fulfilled 以及rejected。状态转变只能是- pending —> fulfilled 或者 pending —> rejected。状态转变不可逆。
    - then 方法可以被同一个 promise 调用多次。
    - then 方法必须返回一个 promise。规范2.2.7中规定， then 必须返回一个新的 Promise
    - 值穿透



## call/apply/bind调用及区别

```js
apply: (thisArg, [param1,param2, param3...]) => result
call: (thisArg, param1,param2, param3...) => result
bind: (thisArg, param1,param2, param3...) => function
```

三个函数都是为了修改this指向问题，除了传参不同，apply、call返回的是传入的函数执行结果， bind是返回传入的函数，可以延缓执行。

## call 实现
```js
Function.prototype.myCall = function (thisArg, ...args) {
   //1.判断参数合法性/////////////////////////
  if (thisArg === null || thisArg === undefined) {
    //指定为 null 和 undefined 的 this 值会自动指向全局对象(浏览器中为window)
    thisArg = window;
  } else {
    thisArg = Object(thisArg);
    //创建一个可包含数字/字符串/布尔值的对象，
    //thisArg 会指向一个包含该原始值的对象。
  }

  //2.搞定this的指向/////////////////////////
  const specialMethod = Symbol("anything"); //创建一个不重复的常量
  //如果调用myCall的函数名是func，也即以func.myCall()形式调用；
  //根据上篇文章介绍，则myCall函数体内的this指向func
  thisArg[specialMethod] = this;
  //给thisArg对象建一个临时属性来储存this（也即func函数）
  //进一步地，根据上篇文章介绍，func作为thisArg对象的一个方法被调用，那么func中的this便
  //指向thisArg对象。由此，巧妙地完成将this隐式地指向到thisArg！
  let result = thisArg[specialMethod](...args); //删除临时方法
  delete thisArg[specialMethod]; //返回临时方法的执行结果
  return result;
}
```

##  apply实现
```js
Function.prototype.myApply = function () {
if (thisArg === undefined || thisArg === null) {
    return window;
  } else {
    thisArg = Object(thisArg);
  }

  function isLikeArray(o) {
    if (
      o && // o不是null、undefined等
      typeof o === "object" && // o是对象
      isFinite(o.length) && // o.length是有限数值
      o.length >= 0 && // o.length为非负值
      o.length === Math.floor(o.length) && // o.length是整数
      o.length < 4294967296
    )
      // o.length < 2^32
      return true;
    else return false;
  }

  let args = arguments[1];
  let result;
  const specialMethod = Symbol("anything");
  thisArg[specialMethod] = this;
  // 处理传进来的第二个参数
  if (args) {
    // 是否传递第二个参数
    if (!Array.isArray(args) && !isLikeArray(args)) {
      throw new TypeError("第二个参数既不为数组，也不为类数组对象。抛出错误");
    } else {
      args = Array.from(args); // 转为数组
      result = thisArg[specialMethod](...args); // 执行函数并展开数组，传递函数参数
    }
  } else {
    result = thisArg[specialMethod]();
  }

  delete thisArg[specialMethod];
  return result; // 返回函数执行结果
}
```

##  bind实现
```js
Function.prototype.myBind = function (objThis, ...params) {
 const thisFn = this; //存储调用函数，以及上方的params(函数参数)
  //对返回的函数 secondParams 二次传参
  let funcForBind = function (...secondParams) {
    //检查this是否是funcForBind的实例？也就是检查funcForBind是否通过new调用
    const isNew = this instanceof funcForBind;

    //new调用就绑定到this上,否则就绑定到传入的objThis上
    const thisArg = isNew ? this : Object(objThis);

    //用call执行调用函数，绑定this的指向，并传递参数。返回执行结果
    return thisFn.call(thisArg, ...params, ...secondParams);
  };
  //复制调用函数的prototype给funcForBind
  funcForBind.prototype = Object(thisFn.prototype);
  return funcForBind; //返回拷贝函数d
};
```
[示例](https://codesandbox.io/s/apply-call-bind-k5vd5?file=/src/App.js)

## instanceof 

```js
function myInstanceof (left, right) {
  if(typeof left !== 'object' || b ===  null) {
    return false
  }
  let proto = left.__proto__
  while(proto) {
    if(proto === null) return false
    if(proto === right.prototype) return true
    proto = proto.__proto
  }
}

```

## Object.create

```js
function createObj(obj, properties) {
  function F() {}
  F.prototype = obj
  let myObj = new F()
  if(typeof properties === 'object') {
    Object.definproperty(myObj, properties)
  }
  return myObj
}
```

## new

- 创建一个新的对象
- 继承父类原型上的方法.
- 添加父类的属性到新的对象上并初始化. 保存方法的执行结果.
- 如果执行结果有返回值并且是一个对象, 返回执行的结果, 否则, 返回新创建的对象。
```js
function myNew1((fn, ...args) ) {
  const obj = new Object()
  obj.__proto__ = fn.prototype
  let res = fn.apply(obj, args)
  return typeof res === 'object' ? res: obj;
}

function myNew2 (fn, ...args) {
  const obj = Object.create({})
  const value = fn.apply(obj, args)
  return value instanceof Object ? value: obj
}
```
{{% admonition type="info" title="new Object.create区别" details="true" %}}

1.传参区别

2.Object.create()如果传入构造函数，是不会调用构造函数的，所以构造函数内部的方法属性无法继承

{{% /admonition %}}

## 浅拷贝shallow clone

```js
//[].concat 、...扩展符、Object.assign({})
function shallowCopy(obj) {
  let result = {}
  for(let key in obj) {
    if(obj.hasOwnProperty(key)) {
      result[key] = obj[key]
    }
  }
  return result
}

```

## 深拷贝 deep clone

```js
function deepClone(obj) {
  let map = new WeakMap();

  function dp(obj) {
    let existObj = map.get(obj);
    // 如果这个对象已被记录则直接返回
    if (existObj) {
      return existObj;
    }
    let keyArr = Object.keys(obj),
      key = null,
      temp = null,
      result = {};
    map.set(obj, result);
    for (let i = 0; i < keyArr.length; i++) {
      key = keyArr[i];
      temp = obj[key];
      if (temp && typeof temp === "object") {
        result[key] = dp(temp);
      } else {
        result[key] = temp;
      }
    }
    return result;
  }

  return dp(obj);
}

```


## xhr

```js
function myAjax(method, url, data) {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest()
    xhr.open(method, url, true)
    xhr.onreadystatechange = function () {
      if(xhr.readyState === 4) {
        if(xhr.status === 200) {
          resolve(xhr.responseText)
        }else {
          reject(xhr.responseText)
        }
       }
    }
    if(method === 'POST') {
      	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    }
    xhr.send(method === 'GET' ? null : data)
  })
}

```



## 实现并发请求
