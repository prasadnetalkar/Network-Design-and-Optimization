param D > 0 integer;
param E > 0 integer;
param N > 0 integer;
param Pd > 0 integer;
param S > 0 integer;

set Nodes := 1..N;
set link_nos := 1..E;
set demand_nos := 1..D;
set route_nos := 1..Pd;
set failure := 0..S;

param link_src {link_nos} within Nodes;
param link_dest {link_nos} within Nodes;
param link_capacity {link_nos} >= 0 integer;
#param link_cost {link_nos} >= 0 integer;

param demand_src {demand_nos} within Nodes;
param demand_dest {demand_nos} within Nodes;

set Routes{demand_nos,route_nos} within link_nos;
param h {demand_nos} >= 0 integer;

param delta {e in link_nos, d in demand_nos, p in route_nos}
= if e in Routes[d,p] then 1 else 0;

param Xds {d in demand_nos,s in failure};
param L {e in link_nos,s in failure};

var x {d in demand_nos, p in route_nos, s in failure} >= 0;
var y {e in link_nos} >= 0;
var r1 {e in link_nos} >= 0;

minimize cost: sum{e in link_nos} (r1[e]);

subj to all_demands {d in demand_nos,s in failure}:
sum{p in route_nos} x[d,p,s] = (Xds[d,s]*h[d]);

subj to capacity_constraints {e in link_nos,s in failure}:
sum{d in demand_nos} sum{p in route_nos} (delta[e,d,p]*x[d,p,s]) <= (L[e,s]*y[e]);

subj to all_capp {e in link_nos}:
(y[e]) <= link_capacity[e];

subj to all_link3 {e in link_nos}:
r1[e] >= (y[e]);

subj to all_link4 {e in link_nos}:
r1[e] >= 3*(y[e])-(2/3)*link_capacity[e];

subj to all_link5 {e in link_nos}:
r1[e] >= 10*(y[e])-(16/3)*link_capacity[e];

subj to all_link6 {e in link_nos}:
r1[e] >= 70*(y[e])-(178/3)*link_capacity[e];

subj to all_link7 {e in link_nos}:
r1[e] >= 500*(y[e])-(1468/3)*link_capacity[e];

subj to all_link8 {e in link_nos}:
r1[e] >= 5000*(y[e])-(16318/3)*link_capacity[e];

