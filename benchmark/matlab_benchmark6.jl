push!(LOAD_PATH, "../FdeSolver.jl/src")
using FdeSolver

push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark

tSpan = [0, 10]     # [intial time, final time]
y0 = [1; 1]             # intial value ([of order 0; of order 1])
β = 2            # order of the derivative
par = [16.0, 4.0] # [spring constant for a mass on a spring, inertial mass]
h = 0.01

function F(t, x, par)

      K = par[1]
      m = par[2]

      - K ./ m .* x

end

JF(t,y,par) = - par[1] ./ par[2]

h=zeros()
Bench6=(zeros(length(H),2,2))

Exact1(t)=y0[1] .* cos(sqrt(par[1] / par[2]) .* t) .+ y0[2] ./ sqrt(par[1] / par[2]) .* sin(sqrt(par[1] / par[2]) .* t)

# benchmark FDEsolver for different step size values
benchmark(MatlabBenchmark.Mdata6, F, JF, Exact, y0, β, par, H)
