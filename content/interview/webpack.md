---
title: "webpack"
date: 2021-05-01T16:25:20+08:00
tags: ['webpack']
draft: false
hiddenFromHomePage: true
toc: true
---

## entry

### 概念

入口起点(entry point) 指示 `webpack` 应该使用哪个模块来作为构建其内部依赖图(dependency graph)的开始。进入入口起点后，webpack 会找出有哪些模块和库是入口起点（直接和间接）依赖的。

默认值是 ./src/index.js，但你可以通过在 webpack configuration 中配置 entry 属性，来指定一个（或多个）不同的入口起点。

### 用法

`entry: string | string[] | {[entryChunkName: string]: string|string[]}`

```js
module.exports = {
  entry: './path/to/my/entry/file.js'
}

module.exports = {
  entry: ['./path/to/my/entry/file.js', './path/to/my/entry/file1.js']
}

//在多页面应用程序中，服务器会传输一个新的 HTML文档给客户端。页面重新加载此新文档，并且资源被重新下载。我们可以使用 optimization.splitChunks 为页面间共享的应用程序代码创建 bundle。由于入口起点增多，多页应用能够复用入口起点之间的大量代码/模块。
module.exports = {
  entry: {
    pageOne: './src/pageOne/index.js',
    pageTwo: './src/pageTwo/index.js',
    pageThree: './src/pageThree/index.js'
  }
};
```

-----------------------------

## output

### 概念

output可以控制 webpack 如何向硬盘写入编译文件。主要输出文件的默认值是 ./dist/main.js，其他生成文件默认放置在 ./dist 文件夹中。

{{% admonition type="info" title="注意，即使可以存在多个 entry 起点，但只指定一个 output 配置。" details="false" %}}
{{% /admonition%}}


### 用法

```js
//将一个单独的 bundle.js 文件输出到 dist 目录中。
module.exports = {
  output: {
    filename: 'bundle.js',
  }
};

//多入口文件：写入到硬盘：./dist/app.js, ./dist/search.js
module.exports = {
  entry: {
    app: './src/app.js',
    search: './src/search.js'
  },
  output: {
    filename: '[name].js',
    path: __dirname + '/dist'
  }
};

module.exports = {
  //...
  output: {
    path: '/home/proj/cdn/assets/[hash]',
    publicPath: 'http://cdn.example.com/assets/[hash]/'
  }
};
```
{{% admonition type="info" title="如果在编译时，不知道最终输出文件的 publicPath 是什么地址，则可以将其留空，并且在运行时通过入口起点文件中的 __webpack_public_path__ 动态设置。" details="true"  %}}

```js
__webpack_public_path__ = myRuntimePublicPath;
```
{{% /admonition%}}

--------------------------

## loader

### 概念
webpack 只能理解 JavaScript 和 JSON 文件。 loader 用于webpack 对模块的源代码进行转换，以供应用程序使用，以及被添加到依赖图中。

### 用法

- 1.配置：在 webpack.config.js 文件中配置loader（推荐）

    ```js
    //webpack.config.js
    module.exports = {
      module: {
        rules: [
          //webpack 对每个 .css 使用 css-loader
          { test: /\.css$/, use: 'css-loader' },
          // 对所有 .ts 文件使用 ts-loader：
          { test: /\.ts$/, use: 'ts-loader' }
        ]
      }
    };
    ```

    {{% admonition type="info" title="多个loader从右边开始执行" details="true" %}}

    在下面的示例中，执行顺序是sass-loader -> css-loader-> style-loader


    ```js
    module.exports = {
      module: {
        rules: [
          {
            test: /\.css$/,
            use: [
              { loader: 'style-loader' },
              {
                loader: 'css-loader',
                options: {
                  modules: true
                }
              },
              { loader: 'sass-loader' }
            ]
          }
        ]
      }
    };
    ```

    {{% /admonition %}}

- 2.内联：import loader
  
    使用`!` 将多个loader分开，`?`拼接参数

    ```js
      import Styles from 'style-loader!css-loader?modules!./styles.css?key=value&foo=bar';
    ```

- 3.CLI: 
  
    ```js
    //这会对 .jade 文件使用 jade-loader, .css 文件使用 style-loader 和 css-loader。
      webpack --module-bind jade-loader --module-bind 'css=style-loader!css-loader'
    ```

### 特性

- 1.可同步，可异步。
- 2.链式调用，按照相反的顺序执行，最后返回webpack期望的JavaScript。
- 3.loader可以在node中运行
- 4.插件(plugin)可以为 loader 带来更多特性。


### 常见loader

- 1.json-loader:  加载 JSON 文件（默认包含）
- 2.样式: 
    - [style-loader](https://v4.webpack.docschina.org/loaders/style-loader) 将模块的导出作为样式添加到 DOM 中
    - [css-loader](https://v4.webpack.docschina.org/loaders/css-loader) 解析 CSS 文件后，使用 import 加载，并且返回 CSS 代码
    - [less-loader](https://v4.webpack.docschina.org/loaders/less-loader) 加载和转译 LESS 文件
    - [sass-loader](https://v4.webpack.docschina.org/loaders/sass-loader) 加载和转译 SASS/SCSS 文件
    - [postcss-loader](https://v4.webpack.docschina.org/loaders/postcss-loader) 使用 PostCSS 加载和转译 CSS/SSS 文件
    - [stylus-loader](https://v4.webpack.docschina.org/loaders/stylus-loader) 加载和转译 Stylus 文件
- 3. 转译
    - [ts-loader](https://v4.webpack.docschina.org/loaders/ts-loader) 或 [awesome-typescript-loader](https://v4.webpack.docschina.org/loaders/awesome-typescript-loader) 像 JavaScript 一样加载 TypeScript 2.0+
    - [script-loader](https://v4.webpack.docschina.org/loaders/script-loader) 在全局上下文中执行一次 JavaScript 文件（如在 script 标签），不需要解析
    - [babel-loader](https://v4.webpack.docschina.org/loaders/babel-loader) 加载 ES2015+ 代码，然后使用 Babel 转译为 ES5
    - [buble-loader](https://v4.webpack.docschina.org/loaders/buble-loader) 使用 Bublé 加载 ES2015+ 代码，并且将代码转译为 ES5
- 4. [eslint-loader](https://v4.webpack.docschina.org/loaders/eslint-loader) PreLoader，使用 ESLint 清理代码
- 5. 文件
    - [file-loader](https://v4.webpack.docschina.org/loaders/file-loader) 将文件发送到输出文件夹，并返回（相对）URL
    - [url-loader](https://v4.webpack.docschina.org/loaders/url-loader) 和 file-loader 类似，但是能在文件很小的情况下以 base64 的方式把文件内容注入到代码中去。可以设置一个阈值，如果小于这个阈值，会转换成内联的base-64 URL，这会减少小文件的 HTTP 请求数。如果文件大于该阈值，会自动的交给 file-loader 处理。

------------------------------

## plugin

### 概念

插件目的在于解决loader无法实现的其他事。loader用于转换某些类型的模块，而插件则可以用于执行范围更广的任务。包括：打包优化，资源管理，注入环境变量。

### 分析

plugin是一个具有apply方法的JS对象,apply被webpack compiler调用，并且compiler 对象可在整个编译生命周期访问。

```js
//ConsoleLogOnBuildWebpackPlugin.js
const pluginName = 'ConsoleLogOnBuildWebpackPlugin';

class ConsoleLogOnBuildWebpackPlugin {
  apply(compiler) {
    //pluginName以驼峰命名的插件名称，可以是常量方便复用。
    compiler.hooks.run.tap(pluginName, compilation => {
      console.log('webpack 构建过程开始！');
    });
  }
}
```

### 用法

由于插件可以携带参数/选项，你必须在 webpack 配置中，向 plugins 属性传入 new 实例。

- 1.配置：webpack.config.js
    ```js
    //webpack.config.js
    const HtmlWebpackPlugin = require('html-webpack-plugin'); //通过 npm 安装
    const webpack = require('webpack'); //访问内置的插件
    const path = require('path');

    module.exports = {
      entry: './path/to/my/entry/file.js',
      output: {
        filename: 'my-first-webpack.bundle.js',
        path: path.resolve(__dirname, 'dist')
      },
      module: {
        rules: [
          {
            test: /\.(js|jsx)$/,
            use: 'babel-loader'
          }
        ]
      },
      plugins: [
        new webpack.ProgressPlugin(),
        new HtmlWebpackPlugin({template: './src/index.html'})
      ]
    };
    ```

-  node

```js
const webpack = require('webpack'); //访问 webpack 运行时(runtime)
const configuration = require('./webpack.config.js');

let compiler = webpack(configuration);

new webpack.ProgressPlugin().apply(compiler);

compiler.run(function(err, stats) {
  // ...
});
```

### 和loader的区别

- 作用不同：loader主要是起到让webpack拥有了加载和解析非JavaScript文件的能力。plugin可以扩展webpack的功能，让webpack具有更多的灵活性。 在 Webpack 运行的生命周期中会广播出许多事件，Plugin 可以监听这些事件，在合适的时机通过 Webpack 提供的 API 改变输出结果。
- 语法不同：loader在rules配置，每一项都是对象；plugin在plugins里面配置，类型为数组，使用前都需要new一个实例

### 自己写一个plugin

一个 webpack plugin 由如下部分组成：

- 一个命名的 Javascript 方法或者 JavaScript 类。
- 它的原型上需要定义一个 `apply` 的方法。
- 注册一个事件钩子。
- 操作webpack内部实例特定数据。
- 功能完成后，调用webpack提供的回调。


```js
//myPlugin.js
class MyPlugin {
  constructor(options) {
    this.options = options;
  }
  apply(compiler) {
    //done 会在一次编译完成后执行。所以这个插件会在每次打包结束，向控制台首先输出 `Hello World!`。
    compiler.hooks.done.tap('My Plugin', (stats) => {
      console.log('Hello World!', this.options.time);
    });
  }
}
module.exports = MyPlugin;

//webpack.config.js
const MyPlugin = require('./myPlugin');
modules.export = {
  plugins:[
      new MyPlugin({ time: '2021.05.20' }),
  ]
}

```

### 参考文章

[https://www.manster.me/?p=872](https://www.manster.me/?p=872)

[https://zhuanlan.zhihu.com/p/102917655](https://zhuanlan.zhihu.com/p/102917655)

-----------------------------

## mode

### 概念

通过设置mode,来启用webpack内置在相应环境下的优化。

mode: development| production | none (默认production)

### 用法
  
- 配置
```js
  module.exports = {
      mode: 'production'
  };
```

- CLI
```js
webpack --mode=production
```

### 三种模式

| 选项        | 描述                                                                                                                                                                                                                                                                                                         |
| :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| development | 将DefinePlugin中的`process.env.NODE_ENV = 'development'` 。启用 NamedChunksPlugin 和 NamedModulesPlugin    。[具体导出](https://v4.webpack.docschina.org/concepts/mode#mode-development)                                                                                                                     |
| production  | 将DefinePlugin中的`process.env.NODE_ENV = 'production'`。启用FlagDependencyUsagePlugin, FlagIncludedChunksPlugin, ModuleConcatenationPlugin, NoEmitOnErrorsPlugin, OccurrenceOrderPlugin, SideEffectsFlagPlugin 和 TerserPlugin。[具体导出](https://v4.webpack.docschina.org/concepts/mode#mode-development) |
| none        | 无任何优化。[具体导出](https://v4.webpack.docschina.org/concepts/mode#mode-development)                                                                                                                                                                                                                      |


------------------------

## 浏览器兼容性

webpack 支持所有符合 ES5 标准 的浏览器（不支持 IE8 及以下版本）。webpack 的 import() 和 require.ensure() 需要 Promise。如果想要支持旧版浏览器，还需要提前加载 polyfill。


## 热更新



## treeShaking 