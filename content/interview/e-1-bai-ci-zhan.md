---
title: ""
date: 2021-05-01T16:25:20+08:00
draft: false
hiddenFromHomePage: true
---

## Q1：typescript中interface 和type的区别

Answer:

{{% admonition type="info" title="1.都可以用来描述对象或函数的类型，但语法不同。" details="true" %}}

```ts
interface SetPoint {
  (x: number, y: number): void;
}

type SetPoint = (x: number, y: number) => void;
```

{{% /admonition %}}

{{% admonition type="info" title="2.type类型别名还可以用于其他类型" details="true" %}}

```ts

//number
type MyNumber = number;

//dom
let div = document.createElement('div');
type MyDiv = typeof div;

```

{{% /admonition %}}


{{% admonition type="info" title="3.extends: interface可以extends interface和type, type也可以extends interface type。但两者语法不同" details="true" %}}

  - interface extends interface
        ```ts
          interface PointX {x: number}
          interface Point extends PointX {y: number}
        ```
  - interface extends type
        ```ts
          type PointX = { x: number; }
          interface Point extends PointX {y: number}
        ```
  - type extends type
        ```ts
          type PointX = { x: number; };
          type PointY= { y: number; };
          type Point =  PointX  & PointY
        ```
  - type extends interface
        ```ts
          type PointX = { x: number; };
          interface PointY  {x: number}
          type Point =  PointX  & PointY
        ```

{{% /admonition %}}


{{% admonition type="info" title="4.interface 可以定义多次，并会合并多次，但type不可以" details="true" %}}
  ```ts
  interface User {
    name: string
  }
  interface User {
    password: string
  }

  //此时User -> {name: string; password: string}
  ```
{{% /admonition %}}

  
{{% admonition type="info" title="5.type 能使用 in 关键字生成映射类型，但 interface 不行。" details="true" %}}
  
```ts
type Status = 200|500

type StatusMap = {
  [key in Status]: string
}

const test:StatusMap  = {
  200: "ok",
  500: "server error"
}

/**
报错 
接口中的计算属性名称必须引用必须引用类型为文本类型或 "unique symbol" 的表达式。
计算属性名的类型必须为 "string"、"number"、"symbol" 或 "any"。
“Status”仅表示类型，但在此处却作为值使用。
**/
//interface StatusMap2 {
//  [key in Status]: string
//}
```

{{% /admonition %}}

{{% admonition type="info" title="6.默认导出方式不同" details="true" %}}
```ts 
export default interface Person {
  name: string
}

//会报错
// export default type Person = {
//   name: string
// }

type Person1 = {
    name: string
}
export default Person1
```
{{% /admonition %}}




## Q: css服务端样式注入

## Q: 1.transform: translateX(20px); 2.margin-left: 20px; 3.position: relative; left: 20px;哪个性能更好？

## Q: 了解哪些css函数

## Q: 了解webpack吗，说一说

## Q: 点击链接跳转前发送的请求会丢失吗

## Q: 协商缓存、强缓存

## Q: 跨域怎么解决  跨域的时候服务端会收到请求吗？客户端会收到返回吗？


## Q: 为什么react项目里会引用react-dom, react-native 里要引用react-dom吗？
## Q：浏览器事件机制（冒泡捕获等）、React事件机制

## Q: 为什么不能在条件语句、循环里用hooks


[官方文档解释](https://zh-hans.reactjs.org/docs/hooks-rules.html#explanation)

[https://zhuanlan.zhihu.com/p/65012054](https://zhuanlan.zhihu.com/p/65012054)


## Q: fiber 了解吗？说一说

## Q: 哪些hooks对应class component 的哪些生命周期

## Q: useEffect里面返回一个函数，这个是发生在什么周期，加上依赖的话也是发生在这个周期吗？

```js
const [name, setName] = useState('')
useState(() => {
  xxxxxxx
  () => xxxxxx
}, [name])
```

## Q: next里面的react 和浏览器里面的react有什么区别？

