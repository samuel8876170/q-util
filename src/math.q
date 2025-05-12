if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];

\d .math
PI: acos -1;

r: {y^x xbar y};
ru: {r[neg abs x;y]};
rd: {r[abs x;y]};

boxMullerBasic: {x#raze{x*/:(cos;sin)@\:y}.(sqrt -2*log@; 2*PI*)@'(n div 2)cut(n:x+1=x mod 2)?1.0};
boxMullerPolar: {x#raze r*\:sqrt(-2*log s)%s:sum r*r:{if[0>=x;:2#()];l,'.z.s n-sum count@'l:l@\:where(c<1)and 0<c:sum l*l:(n div 2) cut -1+(n:x+1=x mod 2)?2.0}x};