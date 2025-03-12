\d .import
if[not count rootDir:{$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];

lib: {[f]
    if[0<type f; :.z.s each f];
    if[all(not null@; {count key` sv`,x})@\:u:`$"." sv -1 _"."vs string f;:debugLog "Library is not going to be imported because it has been imported: ",string f];
    fs: `u#distinct(d .Q.dd/:key d:hsym`$rootDir),$[count qlib:getenv`QLIB;raze ds .Q.dd/:'key each ds:hsym`$";"vs qlib;()];
    if[null p:fs first where fs like "*",(string f),"*";'"Library does not exist: ",string f];
    system "l ", sp:1 _ string p;
    infoLog "Library imported: `",(string f)," from Path: ",sp;
    if[`init in key ns:` sv `,u;
        .Q.dd[ns;`init][];
        infoLog "Executed init function in ",string f
    ]};

debugLog: { $[x~key x;x;-1] y }`.log.debug;
infoLog: { $[x~key x;x;-1] y }`.log.info;

lib`log.q`fs.q;