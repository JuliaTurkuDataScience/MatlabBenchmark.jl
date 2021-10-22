push!(LOAD_PATH, "../FdeSolver.jl/src")
using FdeSolver

push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark

tSpan = [0, 1]     # [intial time, final time]
y0 = 0             # initial value
β = 0.5            # order of the derivative

# Equation
par = β
F(t, y, par) = (40320 ./ gamma(9 - par) .* t .^ (8 - par) .- 3 .* gamma(5 + par / 2)
           ./ gamma(5 - par / 2) .* t .^ (4 - par / 2) .+ 9/4 * gamma(par + 1) .+
           (3 / 2 .* t .^ (par / 2) .- t .^ 4) .^ 3 .- y .^ (3 / 2))
# Jacobian
JF(t, y, par) = -(3 / 2) .* y .^ (1 / 2)

Exact1(t)=t.^8 - 3 * t .^ (4 + β / 2) + 9 / 4 * t.^β

# benchmark FDEsolver for different step size values
benchmark(MatlabBenchmark.Mdata2, F, JF, Exact, y0, β, par, H)
