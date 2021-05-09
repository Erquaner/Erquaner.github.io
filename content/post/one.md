---
title: "apply call bind"
date: 2021-04-19T16:25:20+08:00
draft: false
toc: true
---

## 三者调用及区别

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
