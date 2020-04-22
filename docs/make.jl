using Documenter, DemoCards
using DIPTutorials

templates, theme = cardtheme("list")
tutorials, tutorials_cb = makedemos("tutorials", templates)
dip_examples, dip_examples_cb = makedemos("dip", templates)

format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true",
                         assets = [theme])

makedocs(format = format,
         modules = [DIPTutorials],
         sitename = "Julia 数字图像处理",
         pages = [
            "Home" => "index.md",
            "JuliaImages 入门" => tutorials,
            "DIP 示例代码" => dip_examples,
            "Reference" => "reference.md"
         ]
)

tutorials_cb()
dip_examples_cb()

deploydocs(repo="github.com/johnnychen94/Image-Processing-in-Julia.git")
