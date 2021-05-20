---
title: 'css'
date: 2021-04-20T16:25:20+08:00
draft: false
toc: true
tags: ["css"]
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

## 3.清除浮动

- clear清除浮动（添加空div法）在浮动元素下方添加空div,并给该元素写css样式：
  ```css
  div {
      clear:both;height:0;overflow:hidden;
  }
  ```
- 给浮动元素父级设置高度
- 父级同时浮动（需要给父级同级元素添加浮动）
- 父级设置成inline-block，其margin: 0 auto居中方式失效
- 给父级添加overflow:hidden 清除浮动方法
- 万能清除法 after伪类 清浮动（现在主流方法，推荐使用）
    ```css
    .float_div:after{
      content:".";
      clear:both;
      display:block;
      height:0;
      overflow:hidden;
      visibility:hidden;
    }
    .float_div{
      zoom:1
    }
    ```

-----------------------

## 4.flex布局

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

## 5.css匹配是从右向左匹配的

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

## 6.居中布局

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

## 7.grid

grid是网格布局，分成一块一块的网格；可以说flex是一维布局，而grid是二维布局。和flex类似分为容器和项目。

### 容器属性

- `display: grid`容器是块级元素; `display:inline-grid;`容器是行内元素
- `grid-template-columns` 设置列宽; `grid-template-rows` 设置行高
  ```css
  /*  声明了三列，宽度分别为 200px 100px 200px */
  grid-template-columns: 200px 100px 200px;
   /*  声明了两行，行高分别为 50px 50px  */
  grid-template-rows: 50px 50px;
  ```
    - **repeat() 函数**：可以简化重复的值。该函数接受两个参数，第一个参数是重复的次数，第二个参数是所要重复的值。上面的两行等高就可以写成这样: `grid-template-rows: repeat(2, 50px);`
    - **auto-fill 关键字**：表示自动填充，让一行（或者一列）中尽可能的容纳更多的单元格。`grid-template-columns: repeat(auto-fill, 100px)` 表示列宽是 100 px，但列的数量是不固定的，随着浏览器的宽度自适应放置元素。
    - **fr 关键字**：fr 单位代表网格容器中可用空间的一等份。`grid-template-columns: 200px 1fr 2fr` 表示第一个列宽设置为 200px，后面剩余的宽度分为两部分，宽度分别为剩余宽度的 1/3 和 2/3。
    - **minmax() 函数**：它接受两个参数，分别为最小值和最大值。`grid-template-columns: 1fr 1fr minmax(300px, 2fr)` 表示第三个列宽最少也是要 300px，但是最大不能大于第一第二列宽的两倍。
    - **auto 关键字**：`grid-template-columns: 100px auto 100px` 表示第一第三列为 100px，中间由浏览器决定长度.
- `grid-row-gap` 设置行间距。
- `grid-column-gap`设置列间距。
- `grid-gap` 是`grid-row-gap`、`grid-column-gap`的简写形式。
```css 
  /* 行间距10 */
  grid-row-gap: 10px; 
  /* 列间距20 */
  grid-column-gap: 20px ;

  /* 行间距10,列间距20 */
  grid-gap: 10px 20px; 
```
- `grid-template-areas`:用于定义区域，一个区域由一个或者多个单元格组成(与`grid-area`搭配使用)

- `grid-auto-flow`:类似flex的flex-direction,定义元素怎样排列。默认的放置顺序是"先行后列"(row),column-"先列后行"。`dense`表示尽可能的铺满表格。
- `justify-items`: start | end | center | stretch 设置单元格内容的水平位置（左中右）
- `align-items` : start | end | center | stretch 设置单元格的垂直位置（上中下） 
- `justify-content`: start | end | center | stretch | space-around | space-between | space-evenly 整个内容区域在容器里面的水平位置（左中右）
- `align-content`:  start | end | center | stretch | space-around | space-between | space-evenly  整个内容区域的垂直位置（上中下）。
- `grid-template-columns` 、 `grid-template-rows` 设置隐性网格的列宽列高。

    > grid-template-columns 属性和 grid-template-rows 属性只是指定了两行两列，但实际有九个元素，就会产生隐式网格。通过 grid-auto-rows 可以指定隐式网格的行高为 50px。

### 项目属性

- `grid-column-start` ：左边框所在的垂直网格线
- `grid-row-start` ：上边框所在的水平网格线
- `grid-row-end` ：下边框所在的水平网格线
- `grid-column-end` ：右边框所在的垂直网格线


-  `grid-area`:指定项目放在哪一个区域（与`grid-template-areas`搭配使用）

- `justify-self` 属性设置单元格内容的水平位置（左中右），跟justify-items用法完全一致，但只作用于单个项目
- `align-self` 属性设置单元格内容的垂直位置（上中下），跟align-items用法完全一致，但只作用于单个项目

### 兼容性

![image](https://user-gold-cdn.xitu.io/2020/7/26/17389592fa541366?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### [示例](https://codepen.io/yjuanjuan/pen/GRWJLdN)

---------------------------
## 8.旋转跳跃

### transform

- translate:设置元素在 X轴或者 Y轴上的平移
- scale:设置元素在 X轴或者 Y轴上的缩放
- rotate: 二维空间中，围绕屏幕法向量旋转，等同于 rotateZ
- skew: 设置 X轴和 Y轴的倾斜角度
- matrix

[MDN详情](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transform-function)

### animation


| 属性                      | 描述                                                                | 参考值                                                                                                                                                                                     |
| :------------------------ | :------------------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| animation-duration        | 指定动画完成一个周期所需要时间，单位秒（s）或毫秒（ms），默认是 0。 |
| animation-timing-function | 动画的速度曲线，默认是 "ease"。                                     | `ease`: 慢->快->慢 <br>`line`: 匀速  <br>`ease-in`: 低速开始 <br>`ease-ou`t: 低速结束 始 <br>`cubic-bezier(number, number, number, number)`：特定的贝塞尔曲线类型，4个数值需在[0, 1]区间内 |
| animation-delay           | 指定动画延迟时间，即动画何时开始，默认是 0。                        | number                                                                                                                                                                                     |
| animation-iteration-count | 指定动画播放的次数，默认是 1                                        | number:具体次数 <br>infinite: 无限循环                                                                                                                                                     |
| animation-direction       | 指定动画播放的方向。默认是 normal。                                 | normal：正常方向 <br>  reverse：反方向运行  <br>alternate：动画先正常运行再反方向运行，并持续交替运行  <br> alternate-reverse：动画先反运行再正方向运行，并持续交替运行                    |  |
| animation-fill-mode       | 指定动画填充模式。默认是 none。                                     | none：默认值。不设置对象动画之外的状态 <br>forwards：设置对象状态为动画结束时的状态 <br>backwards：设置对象状态为动画开始时的状态 <br>both：设置对象状态为动画结束或开始的状态             |
| animation-play-state      | 指定动画播放状态，正在运行或暂停。默认是 running。                  | running：运动    <br> paused：暂停                                                                                                                                                         |
| animation-name            | 指定 @keyframes 动画的名称。                                        | string                                                                                                                                                                                     |

[一些动画](https://juejin.cn/post/6854573213230317576)


----------------------------

## 9.响应式布局

>- 自适应布局：同一张网页自动适应不同大小的屏幕，根据屏幕宽度，自动调整网页内容大小。
  
>- 响应式布局：可以自动识别屏幕宽度、并做出相应调整的网页设计，布局和展示的内容可能会有所变动。
    
>- 区别：如果网页内容过多，整体会显得拥挤。所以响应式布局是自适应布局的改进，布局和展示的内容可能会有所变动。




## 参考文章

[grid](https://juejin.cn/post/6854573220306255880)

