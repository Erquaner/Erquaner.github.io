---
title: "es6"
date: 2021-05-01T16:25:20+08:00
draft: false
hiddenFromHomePage: true
tags: ["es6"]
toc: true
---


## 箭头函数

- this指向创建外部的上下文，this是静态的 不能修改指向
- 不能用做构造函数，与new使用会报错
- 没有`argument`,可以用rest
- 不可以使用`yield`命令，因此箭头函数不能用作 `Generator `函数。

-----------------------
## Symbol

{{% admonition type="info" title="1.一种基本数据类型"  details="true"  %}} 

```js
let a = Symbol()
typeof a //"symbol"

```
{{% /admonition %}}
{{% admonition type="info" title="2.Symbol函数的返回值是不相等的。"  details="true"  %}} 


```js

let s1 = Symbol('foo');
let s2 = Symbol('foo');
s1 === s2 // false
```

{{% /admonition %}}

{{% admonition type="info" title="3.Symbol 值不能与其他类型的值进行运算，会报错"  %}} 
{{% /admonition %}}

{{% admonition type="info" title="4.只能转换成String 和Boolean"  details="true" %}} 

```js
let a = Symbol('foo')
String(a) //'Symbol('foo')'

Boolean(a) // true
```

{{% /admonition %}}

{{% admonition type="info" title="5.作为对象属性名需要使用[ ]"  details="true" %}} 

```js
const mySymbol = Symbol();
const a = {
  [mySymbol]: 'mySymbol'
};

a.mySymbol = 'Hello!'; //只是给a添加了一个‘mySymbol’属性
a[mySymbol] // 'mySymbol'
a['mySymbol'] // "Hello!"

```
{{% /admonition %}}


{{% admonition type="info" title="6.遍历属性名使用`Object.getOwnPropertySymbols()`"   details="true" %}} 


- Symbol 作为属性名，for...in、for...of、Object.keys()、Object.getOwnPropertyNames()、JSON.stringify()都无法遍历返回
  
- Reflect.ownKeys()方法可以返回所有类型的键名，包括常规键名和 Symbol 键名。
  
```js
const obj = {};
let a = Symbol('a');
let b = Symbol('b');

obj[a] = 'Hello';
obj[b] = 'World';

const objectSymbols = Object.getOwnPropertySymbols(obj);

console.log(objectSymbols)
// [Symbol(a), Symbol(b)]
```

{{% /admonition %}}


---------------------------------------



## Set

{{% admonition type="info" title="1.类似于数组，但是成员的值都是唯一的，没有重复的值。"  details="true" %}} 

-  判断是否重复相等，类似于=== ， 但在Set内部， NaN ===  NaN 
 
```js
  const person = {age: 1}
  const set1 = new Set([person, person]) //Set(1){age: 1}
  const set2 = new Set([{age: 1}, {age: 1}]) //Set(1){{age: 1}, {age: 1}}
  new Set([NaN, NaN]) //Set(1){NaN}
```

{{% /admonition %}}


{{% admonition type="info" title="2.实例方法。"  details="true"%}} 

- ` Set.prototype.constructor`：构造函数，默认就是Set函数。
- `Set.prototype.size`：返回Set实例的成员总数。

- 操作方法
    - `Set.prototype.add(value)`：添加某个值，返回 Set 结构本身。
    - `Set.prototype.delete(value)`：删除某个值，返回一个布尔值，表示删除是否成功。
    - `Set.prototype.has(value)`：返回一个布尔值，表示该值是否为Set的成员。
    - `Set.prototype.clear()`：清除所有成员，没有返回值。

- 遍历方法
  - `Set.prototype.keys()`：返回键名的遍历器
  - `Set.prototype.values()`：返回键值的遍历器
  - `Set.prototype.entries()`：返回键值对的遍历器
  - `Set.prototype.forEach()`：使用回调函数遍历每个成员

  由于 Set 结构没有键名，只有键值（或者说键名和键值是同一个值），所以keys方法和values方法的行为完全一致。

{{% /admonition %}}

{{% admonition type="info" title="3.应用"  details="true"%}} 

- 数组去重 
  ```js 
  function removeRepeatNumber (arr) {
    const set = new Set(arr)
    return Array.from(set)
  }
  console.log(removeRepeatNumber([1,2,4,3,4,2,3]))
  ```

- 数组求交并集集

```js
  function union (arr1, arr2) {
    return Array.from(new Set([...arr1, ...arr2]))
  }
  console.log(union([1,2,3,4], [2,3,4,5,6]))
```
- 数组求交集
  
```js
  function intersect (arr1, arr2) {
    return arr1.filter(x =>arr2.includes(x))
  }
  console.log(intersect([1,2,3,4], [2,3,4,5,6]))
```
- 数组求差集
  
```js
  function difference (arr1, arr2) {
    return arr1.filter(x => !arr2.includes(x))
  }
  console.log(difference([2,3,4,5,6], [1,2,3,4]))
```


{{% /admonition %}}

{{% admonition type="info" title="4.WeakSet: 和Set相似，都是不重复值的集合"  details="true"%}}

- 与Set的区别

    - 成员必须是对象或者数组，不能是其他值
  ```js
    const ws = new WeakSet();
    ws.add(1)
    // TypeError: Invalid value used in weak set
    ws.add(Symbol())
    // TypeError: invalid value used in weak set
  ```
    - WeakSet中的对象都是弱引用，如果其他对象都不在引用该WeakSet对象，垃圾回收机制会自动回收该对象占用的内存
    - 因为不一定什么时候执行垃圾回收机制， 所以无法遍历，所有遍历方法无法使用，也没有size方法

{{% /admonition %}}

---------------------------

## Map

{{% admonition type="info" title="1.是值-值，任何值都可以做key" %}}

{{% /admonition %}}

{{% admonition type="info" title="2.实例方法" details="true"%}}

- `size`属性返回 Map 结构的成员总数。

- 操作方法
    - `Map.prototype.set(key, value)`: 返回set成功之后的Map对象，可以链式调用 
    - `Map.prototype.get(key)`: 读取key对应的键值，如果找不到key，返回undefined。
    - `Map.prototype.has(key)`: 判断是否有某个键，返回true/false
    - `Map.prototype.delete(key)`: 删除某个键，成功删除返回true,相反返回false
    - `Map.prototype.clear()`: 清空所有成员，无返回值。

- 遍历方法
    - `Map.prototype.keys()`：返回键名的遍历器。
    - `Map.prototype.values()`：返回键值的遍历器。
    - `Map.prototype.entries()`：返回所有成员的遍历器。
    - `Map.prototype.forEach()`：遍历 Map 的所有成员。




{{% /admonition %}}

{{% admonition type="info" title="3.与其他类型的互相转换" details="true"%}}

- 转换为数组(使用扩展运算符)

```js
const myMap = new Map()
  .set(true, 7)
  .set({foo: 3}, ['abc']);
[...myMap]
// [ [ true, 7 ], [ { foo: 3 }, [ 'abc' ] ] ]
```
- 数组 转为 Map(作为构造函数入参)
```js
new Map([
  [true, 7],
  [{foo: 3}, ['abc']]
])
// Map {
//   true => 7,
//   Object {foo: 3} => ['abc']
// }
```
- Map 转为对象
 如果key都是字符串可以直接转换，如果key不是字符串则会被转为字符串在作为key
```js
function strMapToObj(strMap) {
  let obj = Object.create(null);
  for (let [k,v] of strMap) {
    obj[k] = v;
  }
  return obj;
}

const myMap = new Map()
  .set('yes', true)
  .set('no', false);
strMapToObj(myMap)
```
- 对象转为Map(Object.entries())

```js
let obj = {"a":1, "b":2};
let map = new Map(Object.entries(obj));
```
{{% /admonition %}}

{{% admonition type="info" title="4.WeakMap: 与Map类似都是键值对的集合" details="true"%}}

- WeakMap只接受对象或者数组作为键(null除外)
  
```js
    const map = new WeakMap();
    map.set(1, 2)
    // TypeError: 1 is not an object!
    map.set(Symbol(), 2)
    // TypeError: Invalid value used as weak map key
    map.set(null, 2)
    // TypeError: Invalid value used as weak map key
```

- WeakMap中的键都是弱引用，如果对应的键被垃圾回收了，所对应的值也会被回收
  
```js
const  myDiv = document.getElementById('myDiv')
const wMap  = new WeakMap().set(myDiv, 'someThing')

```
    如果`myDiv`后续被删掉了， 那么wMap对应的键值对也会被回收.
    所以 `WeakMap的专用场合就是，它的键所对应的对象，可能会在将来消失。`

-  无法遍历，没有遍历方法以及size属性
-  应用：
      - 上述dom应用
      - 部署私有属性
      ```js
      const _counter = new WeakMap();
      const _action = new WeakMap();

      class Countdown {
        constructor(counter, action) {
          _counter.set(this, counter);
          _action.set(this, action);
        }
      }
      // DONE
      ```
      Countdown类的两个内部属性_counter和_action，是实例的弱引用，所以如果删除实例，它们也就随之消失，不会造成内存泄漏。


{{% /admonition %}}

---------------------------
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

{{% admonition type="info" title="3.defineProperty:拦截了Object.defineProperty()操作" details="true" %}}

```js

var handler = {
  defineProperty (target, key, descriptor) {
    return false;
  }
};
var target = {};
var proxy = new Proxy(target, handler);
proxy.foo = 'bar' // 不会生效

```
上面代码中，defineProperty()方法内部没有任何操作，只返回false，导致添加新属性总是无效。注意，这里的false只是用来提示操作失败，本身并不能阻止添加新属性。

注意，如果目标对象不可扩展（non-extensible），则defineProperty()不能增加目标对象上不存在的属性，否则会报错。另外，如果目标对象的某个属性不可写（writable）或不可配置（configurable），则defineProperty()方法不得改变这两个设置。

{{% /admonition %}}

## reflect 

### 概念

Reflect 是一个内置的对象，它提供拦截 JavaScript 操作的方法。这些方法与proxy handlers的方法相同。Reflect不是一个函数对象，因此它是不可构造的。

### 方法

Reflect对象一共有 13 个静态方法（匹配Proxy的13种拦截行为）。

## 模块化

### CommonJS

{{% admonition type="info" title="同步加载模块(即运行时加载)，加载的是这个模块的浅拷贝" details="true" %}}

```js
// 定义模块math.js
var basicNum = 0;
function add(a, b) {
  return a + b;
}
module.exports = { //在这里写上需要向外暴露的函数、变量
  add: add
}

// 引用自定义的模块时，参数包含路径，可省略.js
var math = require('./math');
math.add(2, 5);

// 引用核心模块(node自带的模块)时，不需要带路径
var http = require('http');
http.createService(...).listen(3000);



//几种写法
// 1. 正确  
module.exports = {  
    name: 'lindaidai',  
    sex: 'boy'  
}  
  
// 2. 正确  
exports.name = 'lindaidai';  
exports.sex = 'boy'  
  
// 3. 正确  
module.exports.name = 'lindaidai';  
module.exports.sex = 'boy'  
  
// 4. 无效  
exports = {  
    name: 'lindaidai',  
    sex: 'boy'  
}  
```

{{% /admonition %}}

### AMD 规范（需要安装requirejs）

{{% admonition type="info" title="1. 出现主要是解决CommonJs同步加载,AMD规范采用异步方式加载模块，模块的加载不影响它后面语句的运行"  %}}

{{% /admonition %}}


{{% admonition type="info" title="2. AMD 推崇依赖前置、提前执行"  %}}

{{% /admonition %}}


{{% admonition type="info" title="3. 所有依赖这个模块的语句，都定义在一个回调函数中，等到加载完成之后，这个回调函数才会运行" details="true" %}}



```js
//math.ts
define(function () {  
  var add = function (a, b) {  
    return a + b;  
  }  
  return {  
    add: add  
  }  
})  


//index.ts
var requirejs = require("requirejs"); //引入requirejs模块  
  
requirejs(['math'],function(math) {  
  console.log(math)  
  console.log(math.add(1, 2));  
})  
```
{{% /admonition %}}


### CMD

{{% admonition type="info" title="1.CMD推崇依赖就近、延迟执行行"  %}}

{{% /admonition %}}

{{% admonition type="info" title="2.引用:define(id?, dependencies?, factory)" details="true"  %}}
```js 

// 所有模块都通过 define 来定义  
define(function(require, exports, module) {  
  
  // 通过 require 引入依赖  
  var $ = require('jquery');  
  var Spinning = require('./spinning');  
  
  // 通过 exports 对外提供接口  
  exports.doSomething = ...  
  
  // 或者通过 module.exports 提供整个接口  
  module.exports = ...  
  
}); 

```
{{% /admonition %}}

> `AMD和CMD最大的区别是对依赖模块的执行时机处理不同(AMD推崇依赖前置,CMD推崇就近依赖)，注意不是加载的时机或者方式不同，二者皆为异步加载模块。`

### ES6 Modules

- `import` 引入,具有提升效果，会提升到模块的首部，首先执行
- `export` 导出
- `export {xx} from 'xxx'` 过渡导出
    ```js
    //a.js
    const add = function () {}
    export {add}
    //b.js
    export {add} from 'a.js'
    //c.js
    import {add} from 'b.js'
    ```
- `import` 的模块变量是不可重新赋值的，它只是个可读引用，不过却可以改写属性
- `import` 、`export`可以出现在模块的任何位置，但如果在块级作用域内会报错。是因为处于条件代码块之中，就没法做静态优化了，违背了ES6模块的设计初衷。
- 与bable转化
    
    转换前
    
    ```js
    // math.js输出
    export const count = 0;

    //index.js引入
    import {count} from './math.js'  
    console.log(count)  

    ```
    
    转换后

    ```js
    // math.js
    "use strict";  
      
    Object.defineProperty(exports, "__esModule", {  
      value: true  
    });  
    exports.count = void 0;  
    const count = 0;  
    exports.count = count;  

    //index.js
    "use strict";  
      
    var _m = require("./m1.js");  
      
    console.log(_m.count);  

    ```

{{% admonition type="info" title="es6 Modules和CommonsJs区别" details="true"  %}}

- CommonJs是值的浅拷贝; ES6 Modules是值的引用，指向内存的地址，输出模块的内部的修改会影响引用的修改
- CommonJS模块是运行时加载，因为加载的是对象（即module.exports）；ES6 Modules是编译时输出接口， ES6模块不是对象，它的对外接口只是一种静态定义，在代码静态解析阶段就会生成。
- CommonJS this指向当前模块，ES6 Modules this指向undefined
- CommonJs导入的模块路径可以是一个表达式，因为它使用的是require()方法；而ES6 Modules只能是字符串
- ES6 Modules中没有这些顶层变量：arguments、require、module、exports、__filename、__dirname
  
{{% /admonition %}}



## [其他新特性](https://github.com/coffe1891/frontend-hard-mode-interview/blob/master/1/1.1.1.md)


## 参考文章

[Proxy](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Proxy)

[Reflect](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Reflect)

[阮一峰es6入门](https://es6.ruanyifeng.com/)


[CommonJS、AMD、CMD、ES6 模块规范讲解](https://segmentfault.com/a/1190000022599809)