if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`time.q`log.q;

\d .fs
mkdir: {[p] if[not count key p; hdel .Q.dd[p; `.tmp] 0: enlist""]; p };
lq: {[p]
    if[not count p; .log.error "Cannot load empty file"; :0b];
    if[not count key hsym`$p; .log.error "File does not exist: ",p; :0b];
    .log.info "Loading code from file: ",p;
    system "l ",p;
    1b
    };
ff: {[ps] ps first where ps~'key each ps };
dfsk: {[d; k] if[d~kd:key d;:d];$[count kd@:where not kd like\:k;raze .z.s[;k] each d .Q.dd/:kd;()] };
dfs: dfsk[;".*"];
dfsa: {[d] if[d~k:key d;:d];$[count k; raze .z.s each d .Q.dd/:k;()] };