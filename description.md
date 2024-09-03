# Headless No-Code CRUD

## Create a Single Table

* `fields.name` : Cannot be "id" since this will be used as primary key.

`POST /api/tables`

Body and Response:
```json
{
    "table_name": "user",
    "fields": [
        {
            "name": "first_name",
            "type": "string" // "boolean", "integer", "date_time", "string"
        },
        {
            "name": "date_of_birth",
            "type": "date_time" 
        }
    ]
}
```

## View All Table

`GET /api/tables`
Response:
```json
[
    {
        "table_name": "user",
        "fields": [
            {
                "name": "first_name",
                "type": "string" // "boolean", "integer", "date_time", "string"
            },
            {
                "name": "date_of_birth",
                "type": "date_time" 
            }
        ]
    }
]
```

## Delete Table

`DELETE /api/tables/:tableName`
```json
{
    "success": true
}
```

## Insert Table Row

`POST /api/:table_name`

```json
{
    "first_name": "Tono",
    "date_of_birth": "2024-08-29T07:42:35Z"
}
```

## Delete TableRow

`DELETE /api/:table_name?id=2&id=3&id=4`

```json
{
    "deleted": [2, 3, 4]
}
```

## Search Table Row

* "operator" : "equal", "not_equal", "lesser", "lesser_equal", "greater", "greater_equal", "ilike"
* "equal", "not_equal" applied to all data types.
* "lesser", "lesser_equal", "greater" and "greater_equal" applied to only integer and date_time
* "ilike" only applies for `string`
* No nested or tree data structure on input.
* "or" means that current field will be operated against the next attribute with OR logic operation.

`POST /api/:table_name/search`

```json
[
    {
        "field": "name",
        "operator": "ilike",
        "value": "ton"
    },
    {
        "field": "name",
        "operator": "not_equal",
        "value": "budi",
        "or": true
    },
    {
        "field": "date_of_birth",
        "operator": "greater_equal",
        "value": "2024-08-29T07:42:35Z",
    },
]
```

Will be translated into

`name ILIKE %stono%s AND name != "budi" OR date_of_birth >= "2024-08-29T07:42:35Z"`

with Response:

```json
{

    "total": 1,
    "items": [
        {
            "first_name": "Tono",
            "date_of_birth": "2024-08-29T07:42:35Z"
        }
    ]
}
```
