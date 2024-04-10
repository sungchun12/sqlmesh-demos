"""a SQLMesh python macro that generates a surrogate key based on the fields provided"""
from sqlglot import exp, generator, parse_one
# from sqlmesh.core.macros import macro

# @macros
def generate_surrogate_key(field_list: list, hash_function='SHA256'):
    """
    Generates a surrogate key by concatenating provided fields,
    treating null values with a specific placeholder,
    then applying a hash function to the result using the database's native SHA256.

    Args:
    - field_list: List of field names to be included in the surrogate key.
    - hash_function: The name of the hash function to be used for generating the surrogate key. Defaults to 'SHA256'.
    
    Returns: An expression (SQLGlot) representing the SQL expression for the generated surrogate key.
    """

    default_null_value = "_sqlmesh_surrogate_key_null_default_"

    expressions = [
        exp.Column(this="column1"),
        exp.Column(this="column2"),
        exp.cast(expression=exp.Column(this="column3"), to='TEXT'),
        exp.Coalesce(this=exp.cast(expression=exp.Column(this="column3"), to='TEXT'), expressions=exp.Literal.string(default_null_value)),
    ]
    print(expressions[2])
    print(expressions[3].sql())
    x

    expressions = []
    for i, field in enumerate(field_list):
        coalesce_expression = exp.Coalesce(
            args=[
                exp.Cast(arg=exp.Column(this=field), to=exp.DataType.Type.TEXT),
                exp.Literal.string(default_null_value)
            ]
        )
        expressions.append(coalesce_expression)
        if i < len(field_list) - 1:  # Add separator except for the last element
            expressions.append(exp.Literal.string('-'))

    print(f"expressions: {expressions[0][0].sql()}")
    # Generating CONCAT expression
    concat_exp = exp.Concat(args=expressions)

    # print(f"concat_exp: {concat_exp}")
    # x

    # Constructing a database-native SHA256 hashing expression
    # Note: The exact representation of the SHA256 function might vary between SQL dialects.
    # This is a generic approach; adjust the SQL function name as required for your target database.
    # hashed_result_exp = exp.Func(
    #     args=[concat_exp],
    #     this=hash_function  # Adjust the function name if your target SQL dialect uses a different name for SHA256
    # )

    return concat_exp

print(generate_surrogate_key(["field1", "field2"]).sql())  # Output: SHA256(CONCAT(COALESCE(CAST(field1 AS TEXT), '_sqlmesh_surrogate_key_null_default_'), '-', COALESCE(CAST(field2 AS TEXT), '_sqlmesh_surrogate_key_null_default_')))

