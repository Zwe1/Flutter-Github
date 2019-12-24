## Flutter 原理

#### Flutter UI

flutter 在原生应用平台之上构建了一套完整的 UI 系统，调用 [OpenGL](https://baike.baidu.com/item/OpenGL/238984?fr=aladdin) 库来间接调用操作系统 API。从而实现跨平台操作，并且保证了原生的渲染性能。

```
    Flutter
      ||
      \/
    OpenGL
      ||
      \/
    OS API
```

#### 绘图原理

一切前端编码都是 GUI 编程，即针对于操作系统硬件绘图能力的应用。

```
     UI (用户界面)
        /\
        ||
        GPU
        /\
        ||
        CPU
```

用户界面由大量的显像单元组成，每个像素点的颜色构成了整个视图界面。我们通过编码来控制像素点色号，从而控制视图成像。编码发出系统指令，CPU 首先根据指令计算内容数据，再交由 GPU 生成每个像素点的色彩数据，最终输出给显像单元呈色。

#### Flutter UI 系统

有 web 开发经验，使用过诸如 React, vue 等框架的同学，理解 Flutter 系统会更加容易些。吸收现代前端构建思路，组件化及声明式，Flutter 也是这一思想的践行者。

```
    Widget                  Component
      ||                       ||
      \/                       \/
    Element                VirtualDOM
      ||                       ||
      \/                       \/
  RenderObject                dom
```

同样以组件为 UI 构成的最小单元，将视图单元抽象成相应的数据结构单元，优化对比算法，获取最小修改集合，通过 patch 来更新视图。整体思想与 web 前端框架如出一辙。

Widget (同比组件) 分为 StatelessWidget 和 StatefulWidget 两类，可类比无状态组件和有状态组件。
