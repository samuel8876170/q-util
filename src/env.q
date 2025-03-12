\d .env
exenv: { if[10h~type first x;:.z.s each x];ssr[;"//";"/"]over{ssr[x;y 0;y 1]}/[x;flip("${",/:o,\:"}";getenv`$o:(deltas each 2 0+/:flip x ss/:("${";"}"))sublist\:x)] };