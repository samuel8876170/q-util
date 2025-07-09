if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];
.import.lib`time.q`log.q;

\d .rr

init: { @[`.rr; `ring; 1#]; @[`.rr; `pointer; 0#] };
addr: {[ringName; ringNodes]
    if[ringName in exec name from ring; .log.info "Ring name already exist in ring table: ",(string ringName),". Use .rr.updr to update existing ring if needed."; :0b];
    .log.info "Adding new ring: `",(string ringName)," with ",(string c:count ringNodes)," nodes.";
    `.rr.ring upsert (ringName; ringNodes; c);
    1b
    };
updr: {[ringName; ringNodes]
    if[not ringName in exec name from ring; .log.info "Ring name not found in ring table: ",(string ringName),". Use .rr.addr to add new ring if needed."; :0b];
    .log.info "Updating existing ring: `",(string ringName)," with ",(string c:count ringNodes)," nodes.";
    `.rr.ring upsert (ringName; ringNodes; c);
    1b
    };
rmr: {[name]
    if[name in exec distinct ringName from pointer; .log.info "Cannot remove ring ",(string name)," because some pointers pointing to this ring."; :0b];
    .log.info "Removing ring: `",(string name),".";
    ring _: name;
    1b
    };
addn: {[ringName; ringNodes]
    if[not ringName in exec name from ring; .log.info "Ring name not found in ring table: ",(string ringName),". Use .rr.addr to add new ring if needed."; :0b];
    .log.info "Adding nodes into existing ring: `",(string ringName)," with ",(string c:count ringNodes)," nodes.";
    update nodes:(nodes,\:ringNodes) from `.rr.ring where name=ringName;
    update n:count each nodes from `.rr.ring where name=ringName;
    1b
    };
rmn: {[ringName; ringNodes]
    if[not ringName in exec name from ring; .log.info "Ring name not found in ring table: ",(string ringName),". Use .rr.addr to add new ring if needed."; :0b];
    .log.info "Adding nodes into existing ring: `",(string ringName)," with ",(string c:count ringNodes)," nodes.";
    update nodes:(nodes except\: ringNodes) from `.rr.ring where name=ringName;
    update n:count each nodes from `.rr.ring where name=ringName;
    1b
    };
addp: {[ringName]
    if[not ringName in exec name from ring; .log.info "Ring name not found in ring table: ",(string ringName),". Add ring before adding pointer to the ring."; :0Ng];
    .log.info "Adding new pointer to ring: `",(string ringName),".";
    `.rr.pointer upsert (id:rand 0Ng; ringName; -1+ring[ringName;`n]);
    id
    };
rmp: {[pid]
    if[not pid in exec id from pointer; .log.info "Pointer id not found in pointer table: ",(string pid),"."; :0b];
    .log.info "Removing ring: ",(string pid),".";
    pointer _: pid;
    1b
    };
pre: {[pid] res[`nodes] (-1+res`ind)mod(res:gps pid)`n };
current: {[pid] res[`nodes] (res:gps pid)`ind };
nex: {[pid] res[`nodes] (1+res`ind)mod(res:gps pid)`n };
roll: {[pid] res:gps pid; pointer[pid;`ind]:i:(1+res`ind)mod res`n;res[`nodes] i };
ring: ([name:`u#`$()] nodes:(); n:"j"$()) upsert (`; (::); 0N);
pointer: ([id:`u#"g"$()] ringName:`.rr.ring$(); ind:"j"$());
gps: {[pid]
    if[not pid in exec id from pointer; .log.info "Pointer not found in pointer table: ",(string pid),"."; :-1];
    first select ind, ringName.nodes, ringName.n from pointer where id=pid
    };