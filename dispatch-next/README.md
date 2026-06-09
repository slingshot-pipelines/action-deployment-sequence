# dispatch-next

GitHub action for dispatching the next deployment in the sequence

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|        INPUT         |  TYPE  | REQUIRED | DEFAULT |                                    DESCRIPTION                                     |
|----------------------|--------|----------|---------|------------------------------------------------------------------------------------|
|      COMPONENT       | string |   true   |         |         The name of the component, for which deployments are being parsed          |
| PREVIOUS_ENVIRONMENT | string |  false   |         | The previous environment, if this has been triggered by a previous deployment step |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->

|      OUTPUT      |  TYPE  |                     DESCRIPTION                      |
|------------------|--------|------------------------------------------------------|
| ALL_ENVIRONMENTS | string |           A JSON array of all environments           |
|       DONE       | string | True if there is no next environment in the sequence |
| NEXT_ENVIRONMENT | string |     The next environment in the sequence, if any     |

<!-- AUTO-DOC-OUTPUT:END -->
