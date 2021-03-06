#   This file is part of Fatou.jl. It is licensed under the MIT license
#   Copyright (C) 2017 Michael Reed

export orbitplot

function orbitplot(u::Function,bi::Matrix{Float64},orb::Int=0,depth::Int=1,incr::Int=384; plt::Function=plot)
  f(x::Float64) = u(x);
  # prepare for next figure
  figure()
  # initalize array to depth
  N = zeros(incr,depth+1);
  bis = zeros(3); bis[1:length(bi)] = bi[:];
  # set x-axis coordinate set
  x = linspace(bi[1],bi[2],incr); N[:,1] = x[:]
  # loop over all discrete x-axis points in set
  for n ∈ 1:length(x)
    # loop function composition at x val
    for t ∈ 1:depth
      N[n,t+1] = f(N[n,t]);
    end
  end
  # plot background lines
  plot(x[:],N[:,1],"k--",x[:],N[:,2])
  # initialize for orbit cobweb
  N2 = zeros(orb+1); N2[1] = bis[3];
  # loop over orbit cobweb
  for t ∈ 1:orb
    # evaluate function composition
    N2[t+1] = f(N2[t]);
  end
  # interleave cobweb orbit data
  siz = 3*(length(N2)-1);
  orbit = zeros(siz,2);
  orbit[1:3:siz,1] = N2[1:end-1];
  orbit[2:3:siz,1] = N2[1:end-1];
  orbit[3:3:siz,1] = N2[2:end];
  orbit[1:3:siz,2] = N2[1:end-1];
  orbit[2:3:siz,2] = N2[2:end];
  orbit[3:3:siz,2] = N2[2:end];
  # plot orbit cobweb path
  plot(orbit[:,1],orbit[:,2],"r")
  # plot f^2,f^3,f^4,...
  for h ∈ 3:depth+1
    plot(x,N[:,h],lw=1);
  end
  if ~(orb == 0)
    plt(linspace(bi[1],bi[2],length(N2)),N2[:],"gray",marker="x",linestyle=":",lw=1)
    funs = [latexstring("\\phi(\\chi_{0:$orb})")];
    funt = ", IC: \$\\chi_0 = $(bis[3])\$, \$\\eta\\in0:$orb\$";
  else
    funs = []; funt = "";
  end
  # trim graph
  d=1.07; xlim(bi[1],bi[2])
  ylim(minimum([d*minimum(N[:,2]),0]),maximum([d*maximum(N[:,2]),0]))
  # set title
  fune = SymPy.latex(u(Sym("\chi")));
  title(latexstring("\$\\chi \\mapsto $fune\$$funt"))
  # set legend
  legend(vcat([L"$\gamma=\chi$",L"$\phi(\chi)$",L"(\chi_\eta,\phi(\chi_n))"],[latexstring("\\phi^{$x}(\\chi)") for x ∈ 2:depth],funs))
  return
end
