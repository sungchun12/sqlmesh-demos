MODEL (
  name demo.fct_sales,
  cron '@daily',
  grain date_month,
  audits (UNIQUE_VALUES(columns = (
    date_month
  )), NOT_NULL(columns = (
    date_month
  )))
);

/* TODO: update this to feel like an actual fact table at the lowest grain */
WITH final AS (
  SELECT
    DATE_TRUNC('MONTH', sub_created_at) AS date_month,
    COUNT(DISTINCT org_id) AS cnt_subscribers,
    SUM(sub_price) AS sum_revenue
  FROM demo.dim_accounts
  WHERE
    NOT sub_created_at IS NULL
  GROUP BY
    1
  ORDER BY
    1
)
SELECT
  *
FROM final