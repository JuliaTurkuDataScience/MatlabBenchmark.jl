# benchmark both standard and Jacobian with additional parameters
function benchmark(Mdata::DataFrame, F, JF, Exact, tSpan::Vector{<:Real}, y0::Union{Real, Vector, Matrix}, β::Union{Real, Vector{<:Real}}, par::Union{Real, Vector{<:Real}}; h0::Int64 = 1)

    H = [2. ^(-i) for i in h0 + 1:8]
    h = 0

    Bench = zeros(length(H), 2, 2)

    t = zeros()
    y = zeros()
    t1 = zeros()
    y1 = zeros()

    for i in 1:length(H)

        h = H[i]

        Bench[i, 1, 1] = mean(@benchmark FDEsolver($F, $tSpan, $y0, $β, $par, h = $h)).time * 10e-10
        Bench[i, 2, 1] = mean(@benchmark FDEsolver($F, $tSpan, $y0, $β, $par, J = $JF, h = $h)).time * 10e-10

        t, y = FDEsolver(F, tSpan, y0, β, par, h = h)
        t1, y1 = FDEsolver(F, tSpan, y0, β, par, J = JF, h = h)

        Bench[i, 1, 2] = norm(y - map(Exact, t), 2)
        Bench[i, 2, 2] = norm(y1 - map(Exact, t), 2)

    end

    # plot logplot of execution time
    p1 = plot(H, Bench[:, :, 1], linewidth = 5, xscale = :log, yscale = :log, title = "Benchmark for Example", yaxis = "Time (Sc)", xaxis = "Step size", label = ["PI_PC" "PI_IM"])
        plot!(H, Mdata[!, 1], linewidth = 5, xscale = :log, yscale = :log, label = "M_PI_PC")
        plot!(H, Mdata[!, 2], linewidth = 5, xscale = :log, yscale = :log, label = "M_PI_IM")

    # plot square norm of the error
    p2 = plot(H[4:end], Bench[4:end, :, 2], yscale = :log, xscale = :log, linewidth = 5, title = "Square norm of the errors", yaxis = "Errors", xaxis = "Step size", label = ["PI_PC" "PI_IM"])
        plot!(H[4:end], Mdata[4:end, 3], linewidth = 5, xscale = :log, ls = :dash, yscale = :log, label = "M_PI_PC")
        plot!(H[4:end], Mdata[4:end, 4], linewidth = 5, xscale = :log, yscale = :log, ls = :dot, label = "M_PI_IM")

    return p1, p2

end

# benchmark only standard without additional parameters
function benchmark(Mdata::DataFrame, F, Exact, tSpan::Vector{<:Real}, y0::Union{Real, Vector{<:Real}, Matrix{<:Real}}, β::Union{Real, Vector{<:Real}}, par::Union{Real, Vector{<:Real}}; h0::Int64 = 1)

    H = [2. ^(-i) for i in h0 + 1:8]
    h = 0

    Bench = zeros(length(H), 2, 2)

    t = zeros()
    y = zeros()
    t1 = zeros()
    y1 = zeros()

    for i in 1:length(H)

        h = H[i]

        Bench[i, 1, 1] = mean(@benchmark FDEsolver($F, $tSpan, $y0, $β, h = $h)).time * 10e-10

        t, y = FDEsolver(F, tSpan, y0, β, h = h)
        Bench[i, 1, 2] = norm(y - map(Exact, t))
        Exact = reshape(Exact(t), length(t), 3)

    end

    # plot logplot of execution time
    p1 = plot(H, Bench[:, 1, 1], linewidth = 5, xscale = :log, yscale = :log, title = "Benchmark for Example 1", yaxis = "Time (Sc)", xaxis = "Step size", label = ["PI_PC" "PI_IM"])
        plot!(H, Mdata[!, 1], linewidth = 5, xscale = :log, yscale = :log, label = "M_PI_PC")
        plot!(H, Mdata[!, 2], linewidth = 5, xscale = :log, yscale = :log, label = "M_PI_IM")

    # plot square norm of the error
    p2 = plot(H[4:end], Bench[4:end, 1, 2], yscale = :log, xscale = :log, linewidth = 5, title = "Square norm of the errors", yaxis = "Errors", xaxis = "Step size", label = ["PI_PC" "PI_IM"])
        plot!(H[4:end], Mdata[4:end, 3], linewidth = 5, xscale = :log, ls = :dash, yscale = :log, label = "M_PI_PC")
        plot!(H[4:end], Mdata[4:end, 4], linewidth = 5, xscale = :log, yscale = :log, ls = :dot, label = "M_PI_IM")

    return p1, p2

end

# benchmark for LongTerm Example
function benchmark(Mdata::DataFrame, F, ::Nothing, tSpan::Vector{<:Real}, y0::Union{Real, Vector{<:Real}, Matrix{<:Real}}, β::Union{Real, Vector{<:Real}},  par::Union{Real, Vector{<:Real}, Vector{Any}}; h0::Int64 = 1)

    H = [2. ^(-i) for i in h0 + 1:8]
    h = 0

    Bench = zeros(length(H), 2, 2)

    t = zeros()
    y = zeros()
    t1 = zeros()
    y1 = zeros()

    for i in 1:length(H)

        h = H[i]

        Bench[i, 1, 1] = mean(@benchmark FDEsolver($F, $tSpan, $y0, $β, $par, h = $h)).time * 10e-10

    end

    # plot logplot of execution time
    p1 = plot(H, Bench[:, 1, 1], linewidth = 5, title = "Benchmark for LongTerm", yaxis = "Time (Sc)", xaxis = "Step size", label = "Julia_PI_PC")
        plot!(H, Mdata[!, 1], linewidth = 5, label = "MATLAB_PI_PC")

    return p1

end
