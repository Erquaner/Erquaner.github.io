---
title: 'css'
date: 2021-04-20T16:25:20+08:00
draft: false
toc: true
hiddenFromHomePage: true
---

## 1.BFC


### 概念: 
BFC 即 Block Formatting Contexts (块级格式化上下文)，就像一个封闭的箱子，不会影响外部的样式，并且具有一些普通容器所没有的特性。


### 触发方式: 

- html根元素
- float不为none (left、right)
- 绝对定位元素：position (absolute、fixed)
- overflow 除了 visible 以外的值 (hidden、auto、scroll)
- display 为 inline-block、table-cells、flex

### 特性:

-  同一个 BFC 下外边距会发生折叠
-  清除浮动
  
      浮动元素会脱离文档流，使父元素高度塌陷

      ```html 
      <div style="border: 1px solid #000;">
        <div style="width: 100px;height: 100px;background: #eee;float: left;"></div>
      </div>
      ```
      此时触发容器的BFC，便可以解决浮动带来的问题
      {{< highlight html "linenos=table,hl_lines=1,linenostart=1" >}}
      <div style="border: 1px solid #000; overflow: hidden">
        <div style="width: 100px;height: 100px;background: #eee;float: left;"></div>
      </div>
      {{< / highlight >}}

- 阻止元素被浮动元素覆盖

### [示例](https://codesandbox.io/s/css-yl8v7)

----------------------------------

## 2.伪类伪元素

伪类伪元素的存在是为了修饰不在文档树中的元素

### 伪类

- 只有处于dom树无法描述的状态下才能为元素添加样式，所以将其称为伪类。用于当元素处于某个状态时，为其添加对应的样式，例如用户悬停在某一元素下可以用`:hover`

- 常见伪类: `:hover` `:active`  `:link`  `:force`  `:disabled` `:not`  `:first-child`  `:first-of-type` `:nth-child `


### 伪元素

- 用于创建不在文档树中的元素，并为其添加样式。比如`::before/:before`可以为某一个元素前面添加文本和样式，但其实这些文本并不在文档树中。

- 常见伪类: `::before/:before` `::after/:after`  `::first-line/:first-line`  `::first-letter/:first-letter`  `::selection` `::placeholder` `::backdrop` 


>css3规范中规定`:`表示伪类，`::`表示伪元素，但也有部分仍旧支持`:`表示伪元素。[详解](http://www.alloyteam.com/2016/05/summary-of-pseudo-classes-and-pseudo-elements/#prettyPhoto)


-----------------------------------


## 3.flex布局

### 基本概念

- 容器：采用 Flex 布局的元素；分为父容器、子容器；父容器可以统一设置子容器的排列方式，子容器也可以单独设置自身的排列方式，如果两者同时设置，以子容器的设置为准。

- 轴：容器默认存在两根轴：水平的主轴和垂直的交叉轴。子容器默认沿主轴排列

### 容器


- 父容器

|      属性       |                                           用途                                            | 值                                                                                                                                                                                                                                                                                                            |
| :-------------: | :---------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| justify-content |                            用于定义如何沿着主轴方向排列子容器                             | flex-start:起始端对齐<br>flex-end:末尾端对齐<br>center:居中对齐<br>space-around:子容器沿主轴均匀分布，位于首尾两端的子容器到父容器的距离是子容器间距的一半<br>space-between:子容器沿主轴均匀分布，位于首尾两端的子容器与父容器相切。                                                                          |
|   align-items   |                              沿着交叉轴方向分配子容器的间距                               | flex-start：起始端对齐<br>flex-end：末尾段对齐<br>center：居中对齐<br>baseline:baseline：基线对齐，这里的 baseline 默认是指首行文字<br>stretch：子容器沿交叉轴方向的尺寸拉伸至与父容器一致                                                                                                                    |
| flex-direction  |                                      决定主轴的方向                                       | row（默认值）：主轴为水平方向，起点在左端<br>row-reverse：主轴为水平方向，起点在右端<br>column：主轴为垂直方向，起点在上沿。<br>column-reverse：主轴为垂直方向，起点在下沿。                                                                                                                                  |
|    flex-wrap    | 默认情况下，所有子容器都排在一条轴线上。flex-wrap属性定义，如果一条轴线排不下，如何换行。 | nowrap（默认）：不换行。<br>wrap：换行，第一行在上方。<br>       wrap-reverse：换行，第一行在下方。                                                                                                                                                                                                           |  |
|    flex-flow    |                       是flex-direction属性和flex-wrap属性的简写形式                       | flex-flow: `flex-direction` &&`flex-wrap`                                                                                                                                                                                                                                                                     |  |
|  align-content  |            定义了多根轴线的对齐方式。如果子容器只有一根轴线，该属性不起作用。             | flex-start：与交叉轴的起点对齐<br>     flex-end：与交叉轴的终点对齐。<br>center：与交叉轴的中点对齐。<br>      space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。<br>space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。<br>stretch（默认值）：轴线占满整个交叉轴。 |  |


- 子容器

|    属性     |                                                                         用途                                                                          | 值                                                        | 备注                                                                                                                                                              |
| :---------: | :---------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    order    |                                                 定义子容器的排列顺序。数值越小，排列越靠前，默认为0。                                                 | number                                                    | -                                                                                                                                                                 |
|  flex-grow  |                                             定义子容器的放大比例，默认为0，即如果存在剩余空间，也不放大。                                             | number                                                    | 如果所有子容器的flex-grow属性都为1，则它们将等分剩余空间（如果有的话）。如果一个子容器的flex-grow属性为2，其他子容器都为1，则前者占据的剩余空间将比其他项多一倍。 |
| flex-shrink |                                            定义了子容器的缩小比例，默认为1，即如果空间不足，该项目将缩小。                                            | number                                                    | 如果所有子容器的flex-shrink属性都为1，当空间不足时，都将等比例缩小。如果一个子容器的flex-shrink属性为0，其他项目都为1，则空间不足时，前者不缩小。                 |
| flex-basis  |                                                    定义了在分配多余空间之前，子容器占据的主轴空间                                                     | length/auto                                               | 它可以设为跟width或height一样的值（比如100px），则项目将占据固定空间。                                                                                            |
| align-self  | 属性允许单个子容器有与其他子容器不一样的对齐方式，可覆盖align-items。默认值为auto，表示继承父容器的align-items属性，如果没有父元素，则等同于stretch。 | auto / flex-start /flex-end / center / baseline / stretch | -                                                                                                                                                                 |
|    flex     |                                       flex属性是flex-grow, flex-shrink 和 flex-basis的简写，默认值为0 1 auto。                                        | `flex-grow` && `flex-shrink` &&  `flex-basis `            | flex: 1 = flex: 1 1 0 <br>flex: 2 = flex: 2 1 0<br>flex: auto = flex: 1 1 auto<br>flex: none = flex: 0 0 auto                                                     |


--------------------------------

## 4.css匹配是从右向左匹配的

如下面为例
```html 
<div className="container">
  <div className="content"> 
    <span>content</span>
  </div>
  <div className="content"> 
    <span>content</span> </div>
    <div className="content">  
      <div className="wrap">
        <span>here</span>
    </div>
  </div>
</div>
```
```css
.container .content .wrap span {color: red;}
```
如果从左向右，大量的性能浪费在了匹配元素上，会先从container开始向下遍历寻找content再继续找wrap 最后找到符合的span。如果在找span的过程中发现某一节点不对，还需要向上回溯，加入有100个content，往上回溯就会很损失性能。

但如果从右向左，会先找到所有的span，对于每一个span再向上找wrap,以此类推。

但如果在叶子上存在多个不符合条件的span，从右向左也会比较耗能。但平均的来看从右向左还是更高效一些。

----------------------

## 5.居中布局

### 行内元素
  
  - 我们可以利用`text-align: center`来实现元素的`水平居中`。

### 块级元素
  
  - 已知宽高
    
      （1）我们可以利用`margin:0 auto`来实现元素的`水平居中`。

      （2）我们可以利用`line-height: height`来实现元素的`垂直居中`。

      （3）利用`position: absolute`+`top: 0; left: 0; right: 0; bottom: 0`+`margin: 0`，由于宽高固定，因此对应方向实现平分，可以实现`水平和垂直居中`。

      （4）利用`position: absolute`，将元素通过`top:50%; left:50%`到页面中心，然后再通过`margin负值`来调整元素的中心点到页面中心,可以实现`水平和垂直居中`。

     

  - 宽高不限
    
      （4）利用`position: absolute`，将元素通过`top:50%; left:50%`到页面中心，然后再通过`translate`来调整元素的中心点到页面的中心,可以实现`水平和垂直居中`。

      （5）使用`display: flex`布局，通过`align-items:center; justify-content:center`设置容器的垂直和水平方向上为居中对齐，实现子元素也可以`垂直水平居中`。

      (6) 使用`display: table`布局，通过`align-items:center; justify-content:center`设置容器的垂直和水平方向上为居中对齐，实现子元素也可以`垂直水平居中`。


--------------------

## 6.grid

grid是网格布局，分成一块一块的网格；可以说flex是一维布局，而grid是二维布局。

[示例](https://codepen.io/yjuanjuan/pen/GRWJLdN)

## 7.旋转跳跃


## 8.响应式布局

>- 什么是自适应布局：同一张网页自动适应不同大小的屏幕，根据屏幕宽度，自动调整网页内容大小。
  
>- 什么是响应式布局：可以自动识别屏幕宽度、并做出相应调整的网页设计，布局和展示的内容可能会有所变动。
    
>- 区别：如果网页内容过多，整体会显得拥挤。所以响应式布局是自适应布局的改进，布局和展示的内容可能会有所变动。



## 
