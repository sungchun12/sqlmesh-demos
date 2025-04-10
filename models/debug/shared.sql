model(name repro.shared, kind embedded);

select
  STRUCT(
    'foo'::STRING AS foo,
    42::INT AS bar,
    -- 'bob'::STRING AS bob
  ) AS strct,
  current_timestamp()::TIMESTAMPTZ AS ts