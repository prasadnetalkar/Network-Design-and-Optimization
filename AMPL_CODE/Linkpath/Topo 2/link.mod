param D > 0 integer;
param Pd > 0 integer;
param E > 0 integer;
param Qe > 0 integer;
param N > 0 integer;

set Nodes := 1..N;
set link_nos := 1..E;
set demand_nos := 1..D;
set route_nos := 1..Pd;
set res_nos := 1..Qe;

param link_src {link_nos} within Nodes;
param link_dest {link_nos} within Nodes;
#param link_cost {link_nos};
param link_capacity {link_nos};
#param link_len {link_nos};

#Generation of Demands
param demand_src {demand_nos} within Nodes;
param demand_dest {demand_nos} within Nodes;
#Generation of Routes
set Routes{demand_nos,route_nos} within link_nos;
set Resroute{link_nos,res_nos} within link_nos;

param h {demand_nos} >= 0 integer;

param delta {e in link_nos, d in demand_nos, p in route_nos}
= if e in Routes[d,p] then 1 else 0;

param beta {l in link_nos, e in link_nos, q in res_nos}
= if l in Resroute[e,q] then 1 else 0;

var x {d in demand_nos, p in route_nos} >= 0;
var y {e in link_nos} >= 0;
var z {e in link_nos, q in res_nos} >=0;
var y1 {e in link_nos} >= 0;
var r1 {e in link_nos} >= 0;

minimize delay: sum{e in link_nos} (r1[e]);

subj to all_demands {d in demand_nos}:
sum{p in route_nos} x[d,p] = h[d];

subj to capacity_constraints {e in link_nos}:
sum{d in demand_nos} ( sum{p in route_nos} (delta[e,d,p]*x[d,p]))- y[e] <= 0;

subj to cap {e in link_nos}:
sum{q in res_nos} z[e,q] = y[e];

subj to cap1 {l in link_nos, e in link_nos:l<>e}:
sum{q in res_nos} beta[l,e,q]*z[e,q] <= y1[l];

subj to all_capp {e in link_nos}:
(y[e]+y1[e]) <= link_capacity[e];

subj to all_link3 {e in link_nos}:
r1[e] >= (y[e]+y1[e]);

subj to all_link4 {e in link_nos}:
r1[e] >= 3*(y[e]+y1[e])-(2/3)*link_capacity[e];

subj to all_link5 {e in link_nos}:
r1[e] >= 10*(y[e]+y1[e])-(16/3)*link_capacity[e];

subj to all_link6 {e in link_nos}:
r1[e] >= 70*(y[e]+y1[e])-(178/3)*link_capacity[e];

subj to all_link7 {e in link_nos}:
r1[e] >= 500*(y[e]+y1[e])-(1468/3)*link_capacity[e];

subj to all_link8 {e in link_nos}:
r1[e] >= 5000*(y[e]+y1[e])-(16318/3)*link_capacity[e];


