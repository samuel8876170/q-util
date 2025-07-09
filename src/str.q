if[not count {$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]; -2 "Environment variable not set: QUTIL. Please set it as path to root of q-util"; exit 1];
if[not count key`.import; system"l ",({$["/"~last x;-1_;::]x}ssr[getenv`QUTIL;"\\";"/"]),"/import.q"];

\d .str
snt: {[s;sep;n] sep sv$[0<n;n#;n _]sep vs s };