model(name repro.incr, kind incremental_by_time_range(time_column ts, forward_only true));

select * from repro.shared where ts between @start_tstz and @end_tstz