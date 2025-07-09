if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`time.q;

\d .log
stdout: -1;
stderr: -2;
level: `info;
validLevel: `debug`info`warning`error`fatal;
debug: {[msg] if[0>(-). validLevel?`debug,level;:(::)]; stdout fmt[`debug;msg] };
info: {[msg] if[0 >(-). validLevel?`info,level;:(::)]; stdout fmt[`info;msg] };
warning: {[msg] if[0>(-). validLevel?`warning,level;:(::)]; stderr fmt[`warning;msg] };
error: {[msg] if[0>(-). validLevel?`error,level;:(::)]; stderr fmt[`error;msg] };
fatal: {[msg] if[0>(-). validLevel?`fatal,level;:(::)]; stderr fmt[`fatal;msg] };
fmt: {[level;msg] "  |  "sv(string .time.p[]; string level; "`",string .Q.host .z.a; "`",string .z.u; (string .z.w),"i"; "`",ssr[{$[type x;x;enlist"q"]}(.Q.btx .Q.Ll`)[2;1;0];"..";""]; msg) };