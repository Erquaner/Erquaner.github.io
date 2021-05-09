---
title: "useReduer（下）"
date: 2019-12-17T21:22:09+08:00
draft: false
---


## useReduer（下）

在实际应用中，我们常常需要很多个变量去管理多个状态。

以下面这个登陆逻辑为例。

```js
function LoginPage() {
  const [name, setName] = useState(''); // 用户名
  const [pwd, setPwd] = useState(''); // 密码
  const [isLoading, setIsLoading] = useState(false); // 是否展示loading，发送请求中
  const [error, setError] = useState(''); // 错误信息
  const [isLoggedIn, setIsLoggedIn] = useState(false); // 是否登录

  const login = (event) => {
    event.preventDefault();
    setError('');
    setIsLoading(true);
    login({ name, pwd })
      .then(() => {
        setIsLoggedIn(true);
        setIsLoading(false);
      })
      .catch((error) => {
          // 登录失败: 显示错误信息、清空输入框用户名、密码、清除loading标识
        setError(error.message);
        setName('');
        setPwd('');
        setIsLoading(false);
      });
  }
  return ( 
    //  返回页面 Element
  )
}
```

可以看出来上面Demo我们定义了5个state来描述页面的状态，在login函数中当登录成功、失败时进行了一系列复杂的state设置。可以想象随着需求越来越复杂更多的state加入到页面，更多的setState分散在各处，很容易设置错误或者遗漏，不利于后期的维护。而且如果在异步函数中，还会触发多次的渲染。

尝试用`useReducer`改写一下

```js
const initState = {
  name: '',
  pwd: '',
  isLoading: false,
  error: '',
  isLoggedIn: false,
}
function loginReducer(state, action) {
  switch(action.type) {
    case 'login':
      return {
        ...state,
        isLoading: true,
        error: '',
      }
    case 'success':
      return {
        ...state,
        isLoggedIn: true,
        isLoading: false,
      }
    case 'error':
      return {
        ...state,
        error: action.payload.error,
        name: '',
        pwd: '',
        isLoading: false,
      }
    default: 
      return state;
  } 
}
function LoginPage() {
const [state, dispatch] = useReducer(loginReducer, initState);
const { name, pwd, isLoading, error, isLoggedIn } = state;
const login = (event) => {
  event.preventDefault();
  dispatch({ type: 'login' });
  login({ name, pwd })
    .then(() => {
      dispatch({ type: 'success' });
    })
    .catch((error) => {
      dispatch({
          type: 'error'
          payload: { error: error.message }
      });
    });
  }
  return ( 
    //  返回页面 Element
  )
}

```

这样让整个代码可读性和维护性都提高了。
