push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark

## inputs
tSpan = [0, 5000] # time span

N = 20 # number of species

β = ones(N) # order of derivatives

X0 = 2*rand(N) # initial abundances

## System definition

# parametrisation
par = [2,
      2*rand(N),
      rand(N),
      4*rand(N,N),
       N]

function F(t, x, par)
    l = par[1] # Hill coefficient
    b = par[2] # growth rates
    k = par[3] # death rates
    K = par[4] # inhibition matrix
    N = par[5] # number of species

# ODE
    Fun = zeros(N)
    for i in 1:N
    # inhibition functions
    f = prod(K[i,1:end .!= i] .^ l ./
             (K[i,1:end .!= i] .^ l .+ x[ 1:end .!= i] .^l))
    # System of equations
    Fun[i] = x[ i] .* (b[i] .* f .- k[i] .* x[ i])
    end

    return Fun

end

# benchmark FDEsolver for different step size values
p1 = benchmark(MatlabBenchmark.MLongTerm, F, nothing, tSpan, X0, β, par, h0 = 4)
