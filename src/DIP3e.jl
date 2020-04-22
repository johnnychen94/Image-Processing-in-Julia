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

function get_artifact_dirpath()
    file_hash = artifact_hash(artifact_name, artifacts_toml)
    if isnothing(file_hash) || !artifact_exists(file_hash)
        new_hash = create_artifact() do artifact_dir
            Threads.@threads for zip_filename in artifact_lists
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
        end
        if isnothing(file_hash)
            bind_artifact!(artifacts_toml, artifact_name, new_hash)
        end
        file_hash = new_hash
    end
    return joinpath(artifact_path(file_hash))
end

function get_filepath(img_name)
    root = get_artifact_dirpath()
    files = filter(x->endswith(lowercase(x), "tif"), readdir(root))
    idx = findfirst(x->occursin(img_name, x), files)
    isnothing(idx) && error("image with \"$(img_name)\" in its name does not exist")
    return joinpath(root, files[idx])
end

end

