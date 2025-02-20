MODEL (
  name game.ref_model_name,
  kind VIEW,
  cron '@daily',
  validate_query false
);


SELECT
  *
from @folder_env("__game.model_name") -- may need to make this a from clause return