model(name repro.latest, kind view);

select * from repro.shared
where ts > current_timestamp() - interval '1' day