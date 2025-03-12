if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`math.q

\d .histo
fd0: `min`max`sum`count`div`avg`med!(min;max;sum;count;div;avg;med);
gh: {[q;a;p;ds]
    s:(count kb)!flip((kb:key a`b),ka:key a`a)!();
    if[not q[`t]in tables[];:s];
    fd: fd0,(enlist`histo)!enlist{count@'group .math.r[x;y where not null y]}[p];
    a[`a]:ka!(fd first@'v),'1_/:v:value a`a;
    ({$[not count x;y;not count y;x;((0*x)uj y)pj x]}/) {[q;a;s;d]
        if[not count data:eval(?;q`t;enlist(enlist(=;`date;d)),$[`c in key q;q`c;()];0b;q`a);:s];
        eval(?;data;();a`b;a`a)
    }[q;a;s] peach ds
    };
ah: {[t;a]  // t: keyed table
    fd: fd0,(enlist`histo)!enlist{z binr'ceiling x*y};
    if[count p:c!({sums(asc key x)#x}@'),/:c:distinct{x[;2]where`histo~/:x[;0]}value a;
        t:({eval(!;x;();0b;y)}/)[t;(::;{(`$"last",/:string k)!(last@'),/:k:key x})@\:p];
        a:(key a)!@[value a;i:where(v:value a[;2])in c;{@[x,last x;2;{`$"last",string x}]}];
    ];
    a:(key a)!(1_@[v;where any(v:(::),value a[;0])~\:/:key fd;fd]),'1_/:value a;
    (count tk)!eval(?;t;();0b;(tk!tk:keys t),a)
    };
