if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`time.q`log.q`dz.q`timer.q`eh.q;

\d .conn
init: { .dz.add[`pc; `.conn.pc] };
add: {[d]
    if[count m:`name`tag`connectable`ep except k:key d; '"Missing arguments: ","," sv string m];
    if[d[`name] in exec distinct name from reg; .log.info "Connection to ",(string d`name)," exists. Not adding another connection to it."; if[`h in k;reg[d`name;`h]:d`h]; :`.conn.reg];
    if[not (d`tag) in exec distinct tag from reg; shjs[d`tag]: .timer.add`valuable`mode`interval`maxBreakTime!((`.conn.shbt; d`tag); `NextPlus;  $[`interval in k; d`interval; 00:00:30]; $[`maxBreakTime in k; d`maxBreakTime; 00:01:00])];
    reg,: (d`name; d`tag; d`connectable; h:$[`h in k;d`h;@[hopen; d`connectable; 0Ni]]; d`ep);
    .log.info "Adding new connection: ",(sName:string d`name)," with tag=",string d`tag;
    if[not null h; exep d`name];
    `.conn.reg
    };
rm: {[name]
    t: reg[name;`tag];
    if[1~exec count i from reg where tag=t; .timer.rm shjs t; shjs _:t];
    reg _: name;
    `.conn.reg
    };
exep: {[name]
    if[all over null ep:reg[name;`ep]; :1b];
    .log.info "Trying to execute entry point for connection ",(sName:string name),": ",sep:.Q.s1 ep;
    $[first r:.eh.trp ep; .log.info "Entry Point for ",sName," successfully executed."; .log.error "Failed to execute entry point for connection ",sName,": ",sep," - error: ",r 1];
    r 0
    };
hbn: { reg[x;`h] };
hsbt: { exec h from reg where tag=x, not null h };
reg: ([name:`$()] tag:`$(); connectable:(); h:"i"$(); ep:()) upsert (`; `; (::); 0Ni; (::));
shjs: (`$())!"g"$();
shbt: {
    if[not count names:exec name from reg where null h, tag=x; :(::)];
    .log.info "Trying to connect all process with tag=",(string x)," - ",strNames:","sv"`",/:string names;
    hs: {@[hopen;reg[x;`connectable];0Ni]}@'names;
    update h:hs from `.conn.reg where name in names;
    .log.info "Successfully connected (",(string count hs ind),"/",(string count names),"): ",","sv string reconnectedNames:names ind:where not null hs;
    exep each reconnectedNames
    };
pc: {
    name: exec first name from reg where h=x;
    reg[name;`h]: 0Ni;
    .log.info "Connection dropped from ",string name;
    };
