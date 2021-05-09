---
title: "unstable_batchedUpdates"
date: 2019-12-14T10:32:35+08:00
draft: false
---

用了Hook一直有一个疑问那就是，怎么能简单的避免异步setState的时候触发多次渲染。

## 避免多次渲染

- 首先想到的就是和class一样，定义一个大的state对象，每次把新改变之后的对象重新set一下。

    但是这样每次操作不同的值都需要在copy一份，避免直接操作state，如果里面又涉及引用类型的值就很麻烦了。

- 其次还可以用useReducer

- 最后这个是听某位星总说的，但还是没有得到广泛应用。

```js
ReactDOM.unstable_batchedUpdates(() => {
  setState1(xxx)
  setState2(xxx)
})
```

这里会直接合并，不会触发两次渲染。[例子](https://codesandbox.io/s/gifted-rgb-p3q2n)







