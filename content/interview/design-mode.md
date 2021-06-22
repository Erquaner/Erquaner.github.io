---
title: "设计模式"
date: 2021-05-04T16:25:20+08:00
draft: false
toc: true
hiddenFromHomePage: true
tags: ["设计模式"]
---


## 发布订阅

```js
class Listen {
  ctor() {
    this.handlers = {};
  }
  on() {
    const [key, handle] = Array.from(arguments);
    if (key in this.handlers) {
      this.handlers[key] = [...this.handlers[key], handle];
    } else {
      this.handlers[key] = [handle];
    }
  }
  emit() {
    const [key, ...param] = Array.from(arguments);
    const handlerArr = this.handlers[key];
    handleArr.forEach((item) => item(...param));
  }
}

const instance = new Listen();
instance.on("touch", (e1, e2) => {});
instance.on("touch", (e1, e2, e3) => {});
instance.emit("touch", e1, e2, e3);
```

## 数据视图双向绑定