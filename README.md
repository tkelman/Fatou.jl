# Fatou.jl

[![Build Status](https://travis-ci.org/chakravala/Fatou.jl.svg?branch=master)](https://travis-ci.org/chakravala/Fatou.jl) [![Coverage Status](https://coveralls.io/repos/chakravala/Fatou.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/chakravala/Fatou.jl?branch=master) [![codecov.io](http://codecov.io/github/chakravala/Fatou.jl/coverage.svg?branch=master)](http://codecov.io/github/chakravala/Fatou.jl?branch=master)

Julia package for Fatou sets.

## Newton Fractals

The first type we are investigating are the Julia sets of the generalized Newton's method.

$$\displaystyle z \mapsto z - m \frac{f(z)}{f'(z)}")$$

Consider the polynomial map `f = z -> z^3-1` with variable `m = 1. To get a Julia function that applies the Newton method to this formula use `η = newton(f,m)`. Repeated function composition converges towards cube-root of 1. For example,
```Julia
julia> ζ = 2.1; [η(ζ), [(η^k)(ζ) for k ∈ 2:4]...]
4-element Array{Float64,1}:
 1.47559
 1.13681
 1.01581
 1.00024
```

This package comes with a plot function designed to visualize real-valued-orbits. The following is a cobweb orbit plot of the function with the Newton method applied to it using `orbitplot(η,[0.4 2.5 2.1],4,2,42)`:

![img/nf1-orbit.png](img/nf1-orbit.png)

The set of points that are within an ϵ neighborhood of the roots ri of the function f is

$$D_0(\epsilon) = \left\\{ z\in\\mathbb{C}: \left|\,z - r_i\,\\right|<\epsilon,\,\forall r_i(\,f(r_i)=0 )\right\}$$

`Fatou` also provides the function `nrset` to display the   the Newton basins using set notation in LaTex.

```Julia
map(display,[nrset(f,m,i) for i ∈ 1:3])
```

$$\displaystyle D_1(\epsilon) = \left\{z\in\mathbb{C}:\left|\,z - \frac{z^{3} - 1}{3 z^{2}} - r_i\,\right|<\epsilon,\,\forall r_i(\,f(r_i)=0 )\right\}$$

$$\displaystyle D_2(\epsilon) = \left\{z\in\mathbb{C}:\left|\,z - \frac{\left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{3} - 1}{3 \left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{2}} - \frac{z^{3} - 1}{3 z^{2}} - r_i\,\right|<\epsilon,\,\forall r_i(\,f(r_i)=0 )\right\}$$

$$\displaystyle D_3(\epsilon) = \left\{z\in\mathbb{C}:\left|\,z - \frac{\left(z - \frac{\left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{3} - 1}{3 \left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{2}} - \frac{z^{3} - 1}{3 z^{2}}\right)^{3} - 1}{3 \left(z - \frac{\left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{3} - 1}{3 \left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{2}} - \frac{z^{3} - 1}{3 z^{2}}\right)^{2}} - \frac{\left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{3} - 1}{3 \left(z - \frac{z^{3} - 1}{3 z^{2}}\right)^{2}} - \frac{z^{3} - 1}{3 z^{2}} - r_i\,\right|<\epsilon,\,\forall r_i(\,f(r_i)=0 )\right\}$$

Now we can compute the Newton fractal Julia set for a function with annotated plot of root convergents (1).

```Julia
f=z -> z^3-1; m = 1; δ = π/2
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],800,ϵ=0.001)
PlotNF(nf,δ,f,m,c="brg")
```

![img/nf1-roots.png](img/nf1-roots.png)

Annotated plot of iteration count
```Julia
f=z -> z^3-1; m = 1; δ = π/2
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],800,ϵ=0.1,N=25,iter=true)
PlotNF(nf,δ,f,m,c="jet")
```

![img/nf1-iter.png](img/nf1-iter.png)


Now change the multiplicity parameter m from 1 to 2 (2). # Repeated function composition produces further singularities:

```Julia
f=z -> z^3-1; m = 2; δ = π/2;
@time orbitplot(newton(f,m), [-π 2π -1],17,3,147); PyPlot.ylim(-2,7)
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],800,N=37,ϵ=0.27,iter=true)
PlotNF(nf,δ,f,m,c="ocean")
nrset(f,m,3)
```

![img/nf2-orbit.png](img/nf2-orbit.png)
![img/nf2-iter.png](img/nf2-iter.png)

$$\displaystyle D_3(\epsilon) = \left\{z\in\mathbb{C}:\left|\,z - \frac{2 \left(z - \frac{2 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{3} - 2}{3 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{2}} - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{3} - 2}{3 \left(z - \frac{2 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{3} - 2}{3 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{2}} - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{2}} - \frac{2 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{3} - 2}{3 \left(z - \frac{2 z^{3} - 2}{3 z^{2}}\right)^{2}} - \frac{2 z^{3} - 2}{3 z^{2}} - r_i\,\right|<\epsilon,\,\forall r_i(\,f(r_i)=0 )\right\}$$

Set multiplicity parameter to `m = -0.5` for this generalized Newton fractal (3):

```Julia
f=z -> z^3-1; m = -0.5; δ = π/2
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],500,N=10)
PlotNF(nf,δ,f,m,c="hsv")
@time orbitplot(newton(f,m), [-2 2 0.9],17,4,147); PyPlot.ylim(-7,2)
```

![img/nf3-limit.png](img/nf3-limit.png)
![img/nf3-limit.png](img/nf3-orbit.png)

Change polynomial function (4):

```Julia
f=z -> z^3-2z-5; m = 1; δ = π/2
@time orbitplot(newton(f,m), [-1.5π π/2 0.2],27,2,147) PyPlot.ylim(-11,3)
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],800,ϵ=0.01,exp=0.3,iter=false)
PlotNF(nf,δ,f,m,c="RdGy")
nrset(f,m,2)
```

![img/nf4-orbit.png](img/nf4-orbit.png)
![img/nf4-roots.png](img/nf4-roots.png)


Generalized Newton fractal example (5):

```Julia
f=z -> z^2-1; m = 1+1im; δ = π/2.4
nf = NewtonFractal(m,f,[-δ,δ,δ,-δ],800,N=10)
PlotNF(nf,δ,f,m,c="hsv")
```

![img/nf5-limit.png](img/nf5-limit.png)

Generalized Newton fractal example (6):

```Julia
f=z -> z^2-1im; m = -0.5+2im; δ = π/2
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],200,N=10)
PlotNF(nf,δ,f,m,c="hsv")
```

![img/nf6-limit.png](img/nf6-limit.png)

Generalized Newton fractal example (7):

```Julia
f=z -> z^8-15z^4-16; m = 1.5; ∂ = [-2π/3,0,-π/3,π/3]
@time orbitplot(newton(f,m), [-2π/3 0 -1.0],17,3,147); PyPlot.ylim(-3,7)
nf = NewtonFractal(m,f,∂,800,N=17,ϵ=0.01)
PlotNF(nf,∂,f,m,c="gist_stern")
nrset(f,m,1)
```
![img/nf7-orbit.png](img/nf7-orbit.png)
![img/nf7-limit.png](img/nf7-limit.png)

Generalized Newton fractal example (8):

```Julia
f=z -> z^8-15z^4-16; m = -0.5+2im; ∂ = [-2π/3,0,-π/3,π/3]
nf = NewtonFractal(m,f,∂,500,N=10)
PlotNF(nf,δ,f,m,c="hsv")
```
![img/nf8-limit.png](img/nf8-limit.png)

Generalized Newton fractal example (9):

```Julia
f=z -> sin(z); m = 1; ∂ = [-2π/3,-π/3,-π/6,π/6]
@time orbitplot(newton(f,m), [-2π/3 -π/3 -1.5],17,3,147); PyPlot.ylim(-30,30)
nf = NewtonFractal(m,f,∂,800,N=17,iter=true,ϵ=0.01)
PlotNF(nf,∂,f,m,c="gist_earth")
nrset(f,m,3)
```
![img/nf9-orbit.png](img/nf9-orbit.png)
![img/nf9-iter.png](img/nf9-iter.png)


Generalized Newton fractal example (10):

```Julia
f=z -> sin(z)-1; m = 1+1im; ∂ = [-2π/3,-π/3,-π/6,π/6]
nf = NewtonFractal(m,f,∂,400,N=33,iter=true,ϵ=0.05)
PlotNF(nf,∂,f,m,c="cubehelix")
nrset(f,m,2)
```

![img/nf10-iter.png](img/nf10-iter.png)

Generalized Newton fractal example (11):

```Julia
f=z -> z^6+z^3-1; m = 1+0.4im; ∂ = [-0.5,0.5,-0,1]
nf = NewtonFractal(m,f,∂,800,N=33,iter=false,ϵ=0.05,exp=0.7)
PlotNF(nf,∂,f,m,c="YlGnBu")
nrset(f,m,1)
```

![img/nf11-limit.png](img/nf11-limit.png)

```Julia
f=z -> cos(z)-1; m = -0.5+2im; δ = π/2
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],350,N=15)
PlotNF(nf,δ,f,m,c="hsv")
```

![img/nf12-limit.png](img/nf12-limit.png)

```Julia
f=z -> cos(z)-1; m = 1; δ = π
nf = NewtonFractal(m,f,[-δ,δ,-δ,δ],300,N=35)
PlotNF(nf,δ,f,m,c="YlGnBu")
display(nrset(f,m,2))
orbitplot(newton(f,m), [-δ δ -2],17,3,147); PyPlot.ylim(-5,1)
```

![img/nf13-roots.png](img/nf13-roots.png)
![img/nf13-orbit.png](img/nf13-orbit.png)

```Julia
f=z -> z^5-3im*z^3-(5+2im)z^2+3z+1; m=1-0.24im; δ=2.0
nf=NewtonFractal(m,f,[-δ,δ,-δ,δ],800,ϵ=0.01,iter=true,N=27)
PlotNF(nf,δ,f,m,c="brg")
nrset(f,m,1)
```

![img/nf14-iter.png](img/nf14-iter.png)

```Julia
f=z -> log(z); m=1+1im; δ=2π
nf=NewtonFractal(m,f,[-δ,δ,-δ,δ],500,ϵ=0.01,iter=false,N=27)
PlotNF(nf,δ,f,m,c="brg")
nrset(f,m,1)
```

![img/nf15-limit.png](img/nf15-limit.png)

```Julia
f=z -> z^(4+3im)-1; m=2.1; δ=π
nf=NewtonFractal(m,f,[-δ,δ,-δ,δ],500,ϵ=0.01,iter=false,N=27)
PlotNF(nf,δ,f,m,c="terrain")
nrset(f,m,1)
```
![img/nf16-limit.png](img/nf16-limit.png)


```Julia
f=z -> e^z+1; m=1; δ=2π
nf=NewtonFractal(m,f,[-δ,δ,-δ,δ],500,ϵ=0.01,iter=true,N=27)
PlotNF(nf,δ,f,m,c="brg")
nrset(f,m,1)
```

![img/nf17-iter.png](img/nf17-iter.png)

