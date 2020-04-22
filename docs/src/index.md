# Julia 数字图像处理

## 简介

目前国内高校数字图像处理课程主要以 [Image Processing ToolBox](https://www.mathworks.com/products/image.html) (MATLAB) 和
[OpenCV](https://opencv.org/) (C++/Python) 为主。因为其语言简单、工具可靠方便，MATLAB 一直属于主流的教学语言。近年来随着 Python
及开源软件的普及和推广， 一些课程开始选择采用 Python 进行围绕 OpenCV 的教学，当然有一些计算机和电子技术专业的课程也会采用 C++ 来进行教学。

作为下一代高性能计算语言, [Julia](https://julialang.org/) 允许我们在不涉及 C 代码的情况下以更少地精力来实现更高效的代码，[JuliaImages](https://juliaimages.org/) 是基于 Julia 开发的高性能通用图像处理工具箱，其特点是：

* 纯 Julia 开发，代码易读易写
* 高性能：有很高的性能上限 + 达到性能上限比较容易
* 比 Python 更加开放的生态环境
* 支持高维矩阵处理：MRI、视频序列、三维空间

关于 Julia 的特点，可以阅读博客[Julia 1.0 正式发布](https://julialang.org/blog/2018/08/one-point-zero-zh_cn/) 以及
[为什么我们要创造Julia](https://julialang.org/blog/2012/02/why-we-created-julia-zh_CN/)。 尽管 Julia 是一门高性能计算语言，
但是这并不意味着实现高性能是一件很容易的事情。实际上，如果不加以训练的话，用 Julia 写出 Python 的速度也是很有可能的。
由于这个原因，本文档有两个目的：

* Julia 下数字图像处理的入门与提高
* 如何实现一个高效的图像处理算法

为了达到这个目的，本文档由两部分组成：

* [JuliaImages 入门](@ref tutorials_index)是一些关于 Julia 及 Julia 下图像处理的系列导论，它介绍
  了 JuliaImages 的基本生态以及一些 Julia 下的编程实践，这里面的内容一部分来源于
  [Julia 官方文档](https://docs.julialang.org/en/v1/) 以及 [JuliaImages 官方文档](https://juliaimages.org/stable/)。
  推荐按顺序阅读。
* [DIP示例代码](@ref dip_index) 用 Julia 实现了[1]和[2]中涉及到的一些例子和习题，可以与教材[1]和
  [JuliaImages 入门](@ref tutorials_index) 配套使用。之所以选择实现[1]的原因是它比较适合数字图像处理的初学者（一二年级本科生）。
  可以按照任意顺序阅读。

!!! warning
    🚧 目前 JuliaImages 还处于早期开发阶段，尽管已经能够满足大部分科研需求，但是还并不适合调包党来无脑使用。

尽管文档中涉及的代码都是可以运行的，但是为了加深理解，最好在阅读本文档之前先对 Julia 及其语法有一些基本的认识，以下是一些比较好的
参考材料：

* [Julia 官方文档](https://docs.julialang.org/en/v1/) 属于最权威的教程及参考材料，绝大部分开发者都是通过该文档来学习 Julia 的。
  其缺点是想要阅读它需要有一些其他语言的开发经验。
* [JuliaBox Tutorials](https://github.com/JuliaComputing/JuliaBoxTutorials) 是 [Julia Computing](https://juliacomputing.com/)
  发布的一系列入门教程， Julia 语言早期的核心开发者都任职于 Julia Computing 中。在 YouTube 上能找到配套视频教程。
* [Julia 编程基础](https://github.com/hyper0x/JuliaBasics) 是目前为数不多的比较好的中文 Julia 语言入门材料。其缺点很明显：
  它仅仅只是对语言本身的介绍，可以理解为 Julia 官方文档的简易版本。其优点也非常明显：适合初学者。

## 代码环境

每段代码均提供三个版本：网页版（你正在阅读的内容）、源代码以及基于nbviewer的jupyter notebook版本。如果想要在本地搭建同样的环境并执行，
只需要使用同样的 [`Project.toml`](https://github.com/johnnychen94/Image-Processing-in-Julia/blob/master/docs/Project.toml)
和 [`Manifest.toml`](https://github.com/johnnychen94/Image-Processing-in-Julia/blob/master/docs/Manifest.toml)
即可，在 linux 和 macos 的命令行下可以这样操作：

```bash
# bash
git clone https://github.com/johnnychen94/Image-Processing-in-Julia.git
cd "Image-Processing-in-Julia"
# 初始化 docs 项目
julia --project=docs/ -e "using Pkg; Pkg.instantiate()"
# 打开 Julia 并激活 docs 项目
julia --project=docs/
```

下面是本文档编译时使用的版本，如果你在运行文档时遇到错误，请检查使用的 Julia 及相应工具箱版本。

```@setup version
using Pkg, InteractiveUtils
Pkg.activate("..")
```

```@repl version
using Pkg, Dates
today()
versioninfo()
Pkg.status()
```

其中 [`DemoCards`](https://github.com/johnnychen94/DemoCards.jl) 与 [`Documenter`](https://github.com/JuliaDocs/Documenter.jl)
是用来生成本文档的工具，可以不用关注。除此之外的包均需要安装，安装可以通过下述方式进行：

```julia
# 安装 Images 等包
(v1.4) pkg> add Images@0.22
# 安装 DIPTutorials -- not registered in General
(v1.4) pkg> add https://github.com/johnnychen94/Image-Processing-in-Julia
```

## 参考文献

* [1] Gonzalez, Rafael C., Richard E. Woods, and Barry R. Masters. "Digital image processing third edition." Pearson (2008). [中文版](https://item.jd.com/12191950.html)
* [2] Gonzalez, Rafael C., and Richard E. Woods "Digital image processing fourth edition." Pearson (2017).
