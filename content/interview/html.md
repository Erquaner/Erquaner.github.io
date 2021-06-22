---
title: "html"
date: 2021-05-04T16:25:20+08:00
draft: false
toc: true
hiddenFromHomePage: true
tags: ["html"]
---

## html语义化

语义化是指根据内容的结构化（内容语义化），选择合适的标签（代码语义化），便于开发者阅读和写出更优雅的代码的同时，让浏览器的爬虫和机器很好的解析。

- 优点
    - 有利于SEO，有助于爬虫抓取更多的有效信息，爬虫是依赖于标签来确定上下文和各个关键字的权重。
    - 语义化的HTML在没有CSS的情况下也能呈现较好的内容结构与代码结构
- 常见的语义化标签
    - <article>
    - <footer>
    - <header>
    - <main>
    - <section>

## viewport:用户网页的可视区域

### 用法
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

### 属性

- width：控制 viewport 的大小，可以指定的一个值，如 600，或者特殊的值，如 device-width 为设备的宽度（单位为缩放为 100% 时的 CSS 的像素）。
- height：和 width 相对应，指定高度。
- initial-scale：初始缩放比例，也即是当页面第一次 load 的时候缩放比例，默认值1。
- maximum-scale：允许用户缩放到的最大比例。
- minimum-scale：允许用户缩放到的最小比例。
- user-scalable：用户是否可以手动缩放。




