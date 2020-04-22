module DIP3e

using Printf
using Pkg.Artifacts
const artifacts_toml = abspath(@__DIR__, "..", "Artifacts.toml")
const artifact_name = "dip3e_data"
const artifacts_url_prefix = "http://www.imageprocessingplace.com/downloads_V3/dip3e_downloads/dip3e_book_images/"
const artifact_lists = append!(map(idx->@sprintf("DIP3E_CH%02d_Original_Images.zip", idx), 1:12),
                               ["DIP3E_CH08_Original_Video_Clips.zip",
                                "DIP3E_Problem_Figures.zip"])

using ZipFile

function get_artifact_dirpath(ch_idx::Integer)
    artifact_name = @sprintf "DIP3E_CH%02d" ch_idx
    file_hash = artifact_hash(artifact_name, artifacts_toml)
    if isnothing(file_hash) || !artifact_exists(file_hash)
        new_hash = create_artifact() do artifact_dir
            zip_filename = artifact_name * "_Original_Images.zip"
            @info "downloading and unzipping dataset $(zip_filename)"
            src_url = joinpath(artifacts_url_prefix, zip_filename)
            download_path = joinpath(artifact_dir, zip_filename)
            download(src_url, download_path)
            isfile(download_path) || error("failed to download $(download_path), please try it again.")
            r = ZipFile.Reader(download_path)
            for f in r.files
                fname = basename(f.name)
                isempty(fname) && continue
                write(joinpath(artifact_dir, basename(f.name)), read(f))
            end
            close(r)
            rm(download_path)
        end
        if isnothing(file_hash)
            bind_artifact!(artifacts_toml, artifact_name, new_hash, lazy=true)
        end
        file_hash = new_hash
    end
    return joinpath(artifact_path(file_hash))
end

"""
    get_filepath(img_name)

Return the path to the image file with `img_name` in its name.

# Examples

```julia
using DIPTutorials
DIP3e.get_filepath("0101") # figure 1.1
```

See also: [`DIP3e.list_filenames`](@ref)
"""
function get_filepath(img_name::AbstractString)
    m = match(r"(\d+)", img_name)
    isnothing(m) && error("Unrecognized file name \"$(img_name)\".")
    ch_idx = parse(Int, m.captures[1][1:2])
    files = list_filenames(ch_idx; abspath=true)

    idx = findfirst(x->occursin(img_name, x), files)
    if isnothing(idx)
        error("image with \"$(img_name)\" in its name does not exist, please check possible filename with `DIP3e.list_filenames($(ch_idx))` ")
    end
    return files[idx]
end

"""
    list_filenames(idx::Integer; abspath=false)

Return a list of filenames available in chapter `idx`.

If `abspath` is `true`, then each item is a path that you can directly load.

# Examples

```julia
using DIPTutorials
DIP3e.list_filenames(1) # all figures in chapter 1
```

See also: [`DIP3e.get_filepath`](@ref)
"""
function list_filenames(ch_idx::Integer; abspath=false)
    root = get_artifact_dirpath(ch_idx)
    files = filter(x->endswith(lowercase(x), "tif"), readdir(root))
    return abspath ? joinpath.(root, files) : files
end

end

