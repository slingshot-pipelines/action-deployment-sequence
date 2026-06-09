# dispatch-next

GitHub action for dispatching the next deployment in the sequence

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|      INPUT       |  TYPE  | REQUIRED | DEFAULT |                     DESCRIPTION                      |
|------------------|--------|----------|---------|------------------------------------------------------|
|    COMPONENT     | string |   true   |         | The name of the component to dispatch deployment for |
|   GITHUB_TOKEN   | string |  false   |         |      Optional Github token to use for dispatch       |
| NEXT_ENVIRONMENT | string |   true   |         |      The environment to dispatch deployment for      |
|       TAG        | string |   true   |         |              The git tag to deploy with              |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->
No outputs.
<!-- AUTO-DOC-OUTPUT:END -->
