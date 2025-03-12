if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];

\d .time
mode: 0;
map: ([] p:`.z.P`.z.p; z:`.z.Z`.z.z; n:`.z.N`.z.n; t:`.z.T`.z.t; d:`.z.D`.z.d);
p: { value map[`p] $[null x;mode;x] };
z: { value map[`z] $[null x;mode;x] };
n: { value map[`n] $[null x;mode;x] };
t: { value map[`t] $[null x;mode;x] };
d: { value map[`d] $[null x;mode;x] };
h: { `hh$t x };
m: { `mm$t x };
s: { `ss$t x };
hm: { `hh`mm$t x };
hs: { `hh`ss$t x };
ms: { `mm`ss$t x };
hms: { `hh`mm`ss$t x };
dh: { d[x],`hh$t x };
dhm: { d[x],`hh`mm$t x };
nextDay: { `timestamp$1+`date$ts:p x };
nextHour: { (`date$ts)+01:00+(`long$01:00)xbar `minute$ts:p x };
nextMin: { (`date$ts)+00:01+(`long$00:01)xbar `minute$ts:p x };
nextSec: { (`date$ts)+00:00:01+(`long$00:00:01)xbar `second$ts:p x };
nextMil: { (`date$ts)+00:00:00.100+(`long$00:00:00.100)xbar `time$ts:p x };