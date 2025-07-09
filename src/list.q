if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];

\d .list
ul: {[l; filter; apply] @[l;filter l;apply] };
cl: {[l; n] $[c~last s;-1_;(::)]((0, s),'n,(c:count l)-last s:sums n)sublist\:l };
sl: {[s; sym] `$s vs string sym };
jl: {[s; l] `$s sv string l };
dupl: {[l; n] n#enlist l };
dupe: {[l; n] (n*count l)#l };
diag: { x=/:x:til x };