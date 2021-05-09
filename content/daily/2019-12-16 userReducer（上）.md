---
title: "userReducer（上）"
date: 2019-12-16T10:49:22+08:00
draft: false
---


## userReducer（上）

### 理解useReducer

`useReducer`是一个高级`Hook`，它不像`useEffect`、`useState`等必须hook一样，没有它我们也可以正常完成需求的开发，但`useReducer`可以使我们的代码具有更好的可读性和可维护性。

`reducer`的概念是伴随着`Redux`的出现逐渐在JavaScript中流行起来。但我们并不需要学习Redux去了解Reducer。

简单来说 reducer是一个函数`(state, action) => newState`：接收当前应用的state和触发的动作action，计算并返回最新的state。


[举例说明](https://codesandbox.io/s/wispy-sea-5knst)


这样看起来似乎很完美，可以管理一个大的`state`，利于后期维护。但是如果这个state嵌套了很多层，似乎管理起来就很麻烦了。

```js
function bookReducer(state, action) {
  switch(action.type) {
    // 添加一个用户
    case 'addUser':
        return {
          ...state,
          users: {
            ...state.users,
            [userId]: userId,
          }
        };
    case 'delUser':
        // ....
    default: 
        return state;
  }
}
```

对于这种复杂`state`的场景推荐使用[immer](https://immerjs.github.io/immer/docs/introduction)解决。


### action的理解

`action`：用来表示触发的行为。

我们可以定义一个大的`action`对象，一般一个常规的Action对象通常有type和payload（可选）组成。

```ts
const action = {
  type: '', //本次操作的类型，也是 reducer 条件判断的依据
  payload?: {} //提供操作附带的数据信息
}

```


以上面添加用户为例

```js
const action = {
  type: 'addUser',
  payload: {
    user: {
      userId,
      userName,
    }
  }
}

function bookReducer(state, action) {
  switch(action.type) {
      // 添加一本书
    case 'addUser':
      const { user } = action.payload;
      return {
        ...state,
        books: {
            ...state.users,
            [user.userId]: user,
        }
      };
    case 'delUser':
        // ....
    default: 
        return state;
  }
}
```

