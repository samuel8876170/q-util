if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`time.q`log.q`eh.q`timer.q;

\d .event
init: { @[`.event; `reg`cbreg; 1#] };
add: {[name; v]
    .log.info $[name in exec name from reg; "Updating existing"; "Adding new"]," event (",(string name),"): ",.Q.s1 v;
    `.event.reg upsert (name; v)
    };
rm: {[names]
    delete from `.event.reg where name in names;
    update `u#name from `.event.reg
    };
tgr: {[h; name; cbf]
    cbid: rand 0Ng;
    .log.info "Triggering remote event: ",(string name)," on handle:",(string h)," with callback function (id:",(string cbid),"): ",string cbf;
    `.event.cbreg upsert (cbid; name; cbf);
    if[not first res:h (`.event.scd; name; cbid); 'res 1];
    cbid
    };
scd: {[name; cbid]
    if[not name in exec name from reg; :(0b; "Event name not found: ",string name)];
    .log.info "Scheduling event:",(string name)," triggered by remote on handle:",(string .z.w)," with callbackId:",string cbid;
    .timer.add`valuable`mode`interval!((`.event.ex; name; cbid; .z.w); `UntilSucceed; 0);
    (1b; "OK")
    };
scd0: scd[;0Ng];
ncb: (::);
reg: ([name:`$()] v:()) upsert (`; (::));
cbreg: ([id:"g"$()] eventNameRef:`$(); func:`$()) upsert (0Ng; `; `);
ex: {[name; cbid; zw]
    res: .eh.trp reg[name;`v];
    if[zw in .z.H; neg[zw] (`.event.cb; cbid; res)];
    res
    };
cb: {[cbid; res]
    .log.info "Executing event callback (id:",(string cbid),") from remote event (name:",(string cbreg[cbid;`eventNameRef]),") with response: ",.Q.s1 res;
    r: cbreg[cbid;`func] res;
    delete from `.event.cbreg where id = cbid;
    r
    };