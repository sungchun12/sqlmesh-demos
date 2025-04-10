model(name repro.prev, kind incremental_by_time_range(time_column ts, forward_only true));

select
  STRUCT(
    'foo'::STRING AS foo,
    42::INT AS bar,
  ) AS strct,
  '2025-01-01T00:00:00Z'::TIMESTAMPTZ AS ts