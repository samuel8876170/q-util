\d .bk

ps: ((`level; `price`size); (`price; `size`level));
rncol: {[pre;t] (k!`$(pre,"_"),/:string k:key first t)xcol t };
pv: {[p;x] (`$("lp"p),''x@\:ps[p]0)!'flip@'x@\:ps[p]1 };
fk: {[b;x] (k(>:;<:)[b]"F"$1_'string k:distinct raze key@'x)#/:x };
tf: {[p;t] p:0|(count ps)&p; (,'/)(enlist ?[t;();0b;c!c:cols[t]except`b`a]),value exec rncol["b"]fk[0b]pv[p] b, rncol["a"]fk[1b]pv[p] a from t };