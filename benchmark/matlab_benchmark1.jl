push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark, MittagLeffler

# store problem parameters
tSpan = [0, 5]     # [initial time, final time]
y0 = 1             # intial value
β = 0.6            # order of the derivative

λ = -10
par = λ

# define differential equation and its Jacobian
F(t, y, par) = par * y
JF(t, y, par) = par
Exact1(t) = mittleff(β, λ * t.^β)

# benchmark FDEsolver for different step size values
p1, p2 = benchmark(MatlabBenchmark.Mdata1, F, JF, Exact1, tSpan, y0, β, par)

# open first plot
p1

# open second plot
p2
