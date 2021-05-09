---
title: "createElement and render"
date: 2020-01-31T10:47:01+08:00
draft: false
tags: ["react"]
---

```js
const element = <h1 title="foo">Hello</h1>
const container = document.getElementById("root")
ReactDOM.render(element, container)

// 替换 const element = <h1 title="foo">Hello</h1>
const element = React.createElement(
  "h1",
  { title: "foo" },
  "Hello"
)
```

由此定义转换成如下格式
```js
const element = {
  type: "h1",
  props: {
    title: "foo",
    children: "Hello",
  },
}
```

所以得出基本element数据结构

```js
const element = {
  type, // 'TEXT_ELEMENT' and otherNode
  props: {
    ...props
    children
  },
}
```

