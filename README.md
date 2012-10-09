proptree
========

Small library, analogue of property list but tree, based on JSX syntax

Examples:

KV = {a, b},
PL = {c, [{d, dd}, {g, gg}]},
ARR = {arr, [[{q, qq}, {w, ww}], [{q, qq1}, {w, ww1}]]},

T1 = [KV, PL, ARR].

Get:

get simple KV
> proptree:get_value([a], T1).
b

get branch 
> proptree:get_value([c, d], T1)
dd

get elements from array
> proptree:get_value([arr, q], T1).
[qq,qq1]


Add:

> proptree:add([c, dd], added, T1).
[{c,[{dd,added},{d,dd},{g,gg}]},
 {a,b},
 {arr,[[{q,qq},{w,ww}],[{q,qq1},{w,ww1}]]}]

element to array
> proptree:add([arr, add], added, T1).
[{arr,[[{add,added},{q,qq},{w,ww}],
       [{add,added},{q,qq1},{w,ww1}]]},
 {a,b},
 {c,[{d,dd},{g,gg}]}]

delete
> proptree:delete([c, d], T1).
[{c,[{g,gg}]},
 {a,b},
 {arr,[[{q,qq},{w,ww}],[{q,qq1},{w,ww1}]]}]

> proptree:delete([arr, q], T1). 
[{arr,[[{w,ww}],[{w,ww1}]]},{a,b},{c,[{d,dd},{g,gg}]}]

modify
> proptree:modify([c, d], mod, T1).
[{c,[{d,mod},{g,gg}]},
 {a,b},
 {arr,[[{q,qq},{w,ww}],[{q,qq1},{w,ww1}]]}]

> proptree:modify([arr, q], mod, T1).
[{arr,[[{q,mod},{w,ww}],[{q,mod},{w,ww1}]]},
 {a,b},
 {c,[{d,dd},{g,gg}]}]

