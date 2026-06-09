# parse-dispatch-event

Parse the repository dispatch event

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|     INPUT      |  TYPE  | REQUIRED | DEFAULT |                        DESCRIPTION                        |
|----------------|--------|----------|---------|-----------------------------------------------------------|
| CLIENT_PAYLOAD | string |   true   |         | The client_payload field of the repository_dispatch event |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->

|     OUTPUT     |  TYPE  |         DESCRIPTION          |
|----------------|--------|------------------------------|
|   COMPONENT    | string |  The name of the component   |
| COMPONENT_TYPE | string |  The type of the component   |
|  ENVIRONMENT   | string | The environment to deploy to |
|      TAG       | string |      The tag to deploy       |

<!-- AUTO-DOC-OUTPUT:END -->
