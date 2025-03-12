if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];

\d .pad
nv: {[l] tl: abs type l 0; $[tl in 5h$where sum .Q.t=/:"bxhijefcpmdznuvt"; tl$0; (::)] };
padl0: {[l; n] if[0>type l; l: enlist l]; v: nv l; $[0>type l 0; (n#v),l; (n#v),/:l] };
padr0: {[l; n] if[0>type l; l: enlist l]; v: nv l; $[0>type l 0; l,n#v; l,\:n#v] };
padTop0: {[l; n] if[0>type l; l: enlist l]; if[0>type l 0; l: enlist l]; (n#enlist(count l 0)#nv l),l };
padBottom0: {[l; n] if[0>type l; l: enlist l]; if[0>type l 0; l: enlist l]; l,n#enlist(count l 0)#nv l };
padRound0: {[l; n] padBottom0[;n] padTop0[;n] padr0[;n] padl0[l;n] };