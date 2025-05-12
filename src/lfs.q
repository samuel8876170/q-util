if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`math.q;

\d .lfs

size: 131000;
preptxt: {[f;n;b;s] f 0:();n{[h;b;s;x]h"\n"sv string b?s}[neg h:hopen f;b;s]/"";hclose h};
lfstat: {[f;a] @[`.lfs;`l`h`s`c`d;:;(0W;-0W;0;0;()!"J"$())]; .Q.fs[{[a;x]@[`.lfs;`l`h`s`c`d;:;((&;|;+;+;+)@'`.lfs `l`h`s`c`d)@'(min;max;sum;count;count@'group@)@\:.math.r[a]"F"$x]}a;f] };
scn1lhnp: {[f;a;l;h;p] i:0;sz:-7!f;r:0n;while[null[r]and sz>=size*1+i;r:rand r where(r<>p)and(r:.math.r[a]"F"$read0(f;i*size;size))within(l;h);i+:1];r };
scnflhp: {[f;a;l;h;p] @[`.lfs;`lc`pc`hc;:;0]; .Q.fs[{[l;h;p;a;x]@[`.lfs;`lc`pc`hc;+;sum@/:(p>;p=;p<)@\:x where(x:.math.r[a]"F"$x)within(l;h)]}[l;h;p;a];f]; show `lc`pc`hc!`.lfs `lc`pc`hc };
ithval: {[f;a;i] {[f;a;x]if[(~). 2#x;:x];scnflhp[f;a]. 3#x;if[all(lc<x 3;x[3]<=lc+pc);:x];x[0 1]:x(0 2;2 1)x[3]>lc;x[2]:scn1lhnp[f;a]. 3#x;x[3]-:lc*lc<x 3;show x;-1"";x}[f;a]/[(-0W;0W;scn1lhnp[f;a;-0W;0W;0n];i)]2};