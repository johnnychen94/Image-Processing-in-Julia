module DIPTutorials

export DIP3e

include("DIP3e.jl")
using .DIP3e

"""
A helper package for DIP tutorials: https://johnnychen94.github.io/Image-Processing-in-Julia/dev/

# Examples

```julia
using DIPTutorials, FileIO
imgfile = DIP3e.get_filepath("0101") # figure 1 in chapter 1
img = load(imgfile)
```
"""
DIPTutorials

end
