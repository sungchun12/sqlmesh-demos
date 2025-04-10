model(name repro.union_, kind view);

with
  v0 as(select * from repro.prev),
  -- v0 as(select p.* except(strct), struct(p.strct.foo, p.strct.bar, NULL::STRING as bob) as strct from repro.prev as p),
  v1 as(select * from repro.incr)
select strct,ts from v0
union all
select strct,ts from v1