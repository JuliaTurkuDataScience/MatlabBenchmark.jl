push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark

# Parameters
tSpan = [0, 1]         # Time Span
y0 = [0; 0]     # Initial values
β = 1.5    # Order of derivation

# Definition of the System
F(t, y, β) = t.^β * y .+ 4 * sqrt(t / π) .- t.^(2 + β)

JF(t,y,β) = t.^β
par=β

Exact(t) = t.^2

# benchmark FDEsolver for different step size values
p1, p2 = benchmark(MatlabBenchmark.Mdata5, F, JF, Exact, tSpan, y0, β, par)

# open first plot
p1

# open second plot
p2
