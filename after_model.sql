MODEL (
  kind FULL,
  name demo.after_model,
  grain user_credit_product_id,
  clustered_by user_id
);

WITH asset_previews AS (
 SELECT
  user_id
  , coalesce(file_hash /* web/desktop */, product_uuid /* web/desktop */, object_permalink /* mobile */, object_uuid /* mobile */) AS credit_product_internal_id
  , timestamp AS ts
  , surface_name
  , DATE_DIFF(CURRENT_DATE, date(timestamp), DAY) AS days_ago
 FROM data-178420.segment.events
 WHERE
  event = 'asset_previewed' AND timestamp > CURRENT_TIMESTAMP() - INTERVAL '90' DAY AND NOT user_id IS NULL AND coalesce(product_type /* web/desktop */, object_type /* mobile */) = 'sample'
), agged AS (
 SELECT
  user_id
  , credit_product_internal_id
  , sum(1.) AS total_asset_previews
  , MAX(ts) AS most_recent_ts
 FROM asset_previews
 WHERE
  NOT credit_product_internal_id IS NULL
 GROUP BY
  1
  , 2
)
SELECT
 SHA256(a.user_id || a.credit_product_internal_id) AS user_credit_product_id
 , a.user_id
 , a.credit_product_internal_id
 , a.total_asset_previews
 , a.most_recent_ts
 , 1 + (
  4.5 * LOG(total_asset_previews, 10)
 ) AS score
 , row_number() OVER (PARTITION BY user_id ORDER BY most_recent_ts DESC) AS user_asset_preview_recency_number
 , row_number() OVER (PARTITION BY user_id ORDER BY total_asset_previews DESC) AS user_asset_preview_totals_rank
FROM agged AS a
INNER JOIN recommendations_samples.dimension_users AS u
 USING (user_id)
INNER JOIN recommendations_samples.dimension_credit_products AS cp
 USING (credit_product_internal_id)