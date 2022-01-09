# Tutorial 02x10: GLMakie Interactive

# Julia v1.5.3

#=
    Package used in this tutorial:
        GLMakie v0.1.30
=#

# Makie.jl Citation: https://doi.org/10.5281/zenodo.4450294

################################################################################

################################################################################
# Observables
################################################################################

using GLMakie

################################################################################
# Sliders
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1, targetlimits = BBox(-10, 10, -10, 10),
    # title
    title = "Sliders Tutorial",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(20), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(20), yticksize = 18
)

# darken axes

vlines!(ax1, [0], linewidth = 2)
hlines!(ax1, [0], linewidth = 2)

# create sliders

lsgrid = labelslidergrid!(fig,
    ["slope", "y-intercept"],
    Ref(LinRange(-10:0.01:10));
    formats = [x -> "$(round(x, digits = 2))"],
    labelkw = Dict([(:textsize, 30)]),
    sliderkw = Dict([(:linewidth, 24)]),
    valuekw = Dict([(:textsize, 30)])
)

# set starting position for slope

set_close_to!(lsgrid.sliders[1], 1.0)

# layout sliders

sl_sublayout = GridLayout(height = 150)
fig[2, 1] = sl_sublayout
fig[2, 1] = lsgrid.layout

# create listener

slope = lsgrid.sliders[1].value

intercept = lsgrid.sliders[2].value

x = -10:0.01:10

y = @lift($slope .* x .+ $intercept)

# add line plot

line1 = lines!(ax1, x, y, color = :blue, linewidth = 5)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# add scatter plot

rx = -10:0.5:10
ry = rand(length(rx)) .+ -rx * 0.5 .+ 3
scatter1 = scatter!(ax1, rx, ry, color = :red, markersize = 15)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# save plot

