MODEL (
  name demo.fct_sales,
  cron '@daily',
  grain date_month,
  audits (
    unique_values(columns=(date_month)),
    not_null(columns=(date_month))
  )
);

-- TODO: update this to feel like an actual fact table at the lowest grain
WITH final AS (
    SELECT 
        date_trunc('month', sub_created_at) as date_month
        , count(distinct org_id) as cnt_subscribers
        , sum(sub_price) as sum_revenue
    FROM demo.dim_accounts
    WHERE sub_created_at is not NULL 
    GROUP BY 1 
    ORDER BY 1
)

SELECT * FROM final