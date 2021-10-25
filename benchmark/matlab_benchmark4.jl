push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark, SpecialFunctions

# Parameters
tSpan = [0, 5]         # Time Span
y0 = [1, 0.5, 0.3]     # Initial values
β = [0.5, 0.2, 0.6]    # Order of derivation

# Definition of the System
function F(t, y)

    F1 = 1 / sqrt(pi) * (((y[2] - 0.5) * (y[3] - 0.3))^(1 / 6) + sqrt(t))
    F2 = gamma(2.2) * (y[1] - 1)
    F3 = gamma(2.8) / gamma(2.2) * (y[2] - 0.5)

    return [F1, F2, F3]

end

Exact4(t) = [t .+ 1; t.^1.2 .+ 0.5; t.^1.8 .+ 0.3]

# benchmark FDEsolver for different step size values
p1, p2 = benchmark(MatlabBenchmark.Mdata4, F, Exact4, tSpan, y0, β)

# open first plot
p1

# open second plot
p2
