"""a SQLMesh python macro that generates a surrogate key based on the fields provided"""

from sqlglot import exp
from sqlmesh.core.macros import macro

# @macro
def generate_surrogate_key(field_list: list):
    """
    Generates a surrogate key by concatenating provided fields,
    treating null values with a specific placeholder,
    then applying a hash function to the result using the database's native SHA256 algorithm.

    Args:
    - field_list: List of field names to be included in the surrogate key.
    
    Returns: An expression (SQLGlot) representing the SQL expression for the generated surrogate key.
    """

    default_null_value = "_sqlmesh_surrogate_key_null_default_"

    expressions = []
    for i, field in enumerate(field_list):
        coalesce_expression = exp.Coalesce(
                this=exp.cast(expression=exp.Column(this=field), to='TEXT'),
                expressions=exp.Literal.string(default_null_value)
        )
        expressions.append(coalesce_expression)
        if i < len(field_list) - 1:  # Add separator except for the last element
            expressions.append(exp.Literal.string('-'))

    concat_exp = exp.Concat(expressions=expressions)
    hash_exp = exp.SHA2(this=concat_exp, length=exp.Literal.number(256))

    return hash_exp

# print(generate_surrogate_key(["field1","aiowjef"]).sql())  # Output: SHA2(CONCAT(COALESCE(CAST(field1 AS TEXT), '_sqlmesh_surrogate_key_null_default_'), '-', COALESCE(CAST(aiowjef AS TEXT), '_sqlmesh_surrogate_key_null_default_')), 256)
