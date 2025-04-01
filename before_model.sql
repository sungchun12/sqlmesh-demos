MODEL (
  kind FULL,
  name demo.before_model,
  grain user_credit_product_id,
  clustered_by user_id
);


with asset_previews as (
  select 
    user_id
    , coalesce(
      file_hash,        -- web/desktop
      product_uuid,     -- web/desktop
      object_permalink, -- mobile
      object_uuid       -- mobile
    ) as credit_product_internal_id
    , timestamp as ts
    , surface_name
    , date_diff(current_date, date(timestamp), day) as days_ago
  from data-178420.segment.events
  where event = 'asset_previewed'
    and timestamp > current_timestamp - interval 90 day
    and user_id is not null
    and coalesce(
      product_type, -- web/desktop
      object_type  -- mobile
    ) = 'sample'
)
, agged as (
  select
    user_id
    , credit_product_internal_id
    , sum(1.) total_asset_previews
    , max(ts) as most_recent_ts
  from asset_previews
  where credit_product_internal_id is not null
  group by 1, 2
)
select 
  sha256(
    a.user_id || a.credit_product_internal_id
  ) as user_credit_product_id
  , a.user_id
  , a.credit_product_internal_id
  , a.total_asset_previews
  , a.most_recent_ts
  , 1 + (4.5 * log10(total_asset_previews)) as score
  , row_number() over(partition by user_id order by most_recent_ts desc) as user_asset_preview_recency_number
  , row_number() over(partition by user_id order by total_asset_previews desc) as user_asset_preview_totals_rank
from agged as a
inner join recommendations_samples.dimension_users as u using(user_id)
inner join recommendations_samples.dimension_credit_products as cp using(credit_product_internal_id)