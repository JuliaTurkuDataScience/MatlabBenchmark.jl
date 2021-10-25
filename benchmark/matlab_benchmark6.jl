push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark

tSpan = [0, 10]     # [intial time, final time]
y0 = [1; 1]             # intial value ([of order 0; of order 1])
β = 2            # order of the derivative
par = [16.0, 4.0] # [spring constant for a mass on a spring, inertial mass]

function F(t, x, par)

      K = par[1]
      m = par[2]

      - K ./ m .* x

end

JF(t, y, par) = - par[1] ./ par[2]

Exact6(t) = y0[1] .* cos(sqrt(par[1] / par[2]) .* t) .+ y0[2] ./ sqrt(par[1] / par[2]) .* sin(sqrt(par[1] / par[2]) .* t)

# benchmark FDEsolver for different step size values
p1, p2 = benchmark(MatlabBenchmark.Mdata6, F, JF, Exact6, y0, β, par)

# open first plot
p1

# open second plot
p2
