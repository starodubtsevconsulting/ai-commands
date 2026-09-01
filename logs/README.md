# Logs

Status: **TODO / specification placeholder**

Reusable AI command for bounded retrieval and preprocessing of runtime/application logs.

## Result policy

```text
preserve-raw-output: true
result-mode: bounded
```

The command should return a compact/bounded result to the caller while preserving or referencing the relevant raw diagnostic slice when useful and permitted by runtime storage/privacy limits.

## Intended behavior

- accept a bounded diagnostic/log retrieval request;
- select configured logging/observability adapter (local logs, service logs, cloud logging, Datadog, etc.);
- apply time/service/query filters before returning data;
- enforce output/token/line limits;
- preserve provenance to the underlying log source;
- preserve/reference raw diagnostic evidence according to the result policy;
- return enough evidence for a reasoning agent without dumping unbounded logs.

## Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

Commands not listed are not granted. See [`command.spec.md`](../command.spec.md).

## TODO

- define `spec.md`;
- define provider-neutral query inputs/outputs;
- define hard output limits and summarization/filtering behavior;
- define adapters such as local logs and Datadog;
- define authorization/privacy/storage boundaries;
- add tests and implementation.