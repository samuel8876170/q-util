if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`eh.q`time.q`log.q;

\d .dz
reset: {[zs] if[any null zs; :.z.s sfs]; reg[zs]:(count zs:sfs inter zs)#enlist(`u#`$())!`s#"j"$() };
addp: {[z;fs;priority]
    if[not z in sfs; '"Invalid .z function: ",(string z),". Functions supported: ",","sv string sfs];
    if[not 11h~type fs:(),fs; '"Invalid function. Only symbol of functions supported."];
    if[not -7h~type priority; '"Invalid priority. Only long atom supported."];
    if[c:count fs:fs except key reg z; reg[z]: (`u#k)!`s#x k:iasc x:reg[z],fs!c#priority];
    };
add: {[z;fs] addp[z;fs;0W] };
rm: {[z;fs]
    if[not z in sfs; '"Invalid .z function: ",(string z),". Functions supported: ",","sv string sfs];
    if[not 11h~type fs:(),fs; '"Invalid function. Only symbol of functions supported."];
    reg[z]: (`u#key x)!`s#value x:fs _ reg z;
    };
sfs: `po`pc`pg`ps`pw`wo`wc`ws`ts`exit;
reg: (`u#`$())!();
reg[sfs]: (count sfs)#enlist(`u#`$())!`s#"j"$();

.z.po: { (key reg`po)@\:x };
.z.pc: { (key reg`pc)@\:x };
.z.pg: { (key reg`pg)@\:x; value x };
.z.ps: { (key reg`ps)@\:x; value x };
.z.pw: { all (key reg`pw).\:(x;y) };
.z.wo: { (key reg`wo)@\:x };
.z.wc: { (key reg`wc)@\:x };
.z.ws: { (key reg`ws)@\:x; value x };
.z.ts: { (key reg`ts)@\:(::) };
.z.exit: { (key reg`exit)@\:x };