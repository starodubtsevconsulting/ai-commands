# Logs

Status: **TODO / specification placeholder**

Reusable AI command for bounded retrieval and preprocessing of runtime/application logs.

## Inputs

Uses common `profile -> workflow -> source/project` context from [`command.spec.md`](../command.spec.md).

| Input | Required | Meaning |
| --- | --- | --- |
| `profile` | yes | Active AI profile/context. |
| `workflow` | yes | Active workflow context. |
| `source` / `project` | yes | Concrete workflow source/project whose logs are being inspected. |
| `log_source` | yes | Log/observability source such as application/service logs, local runtime, cloud logging, Datadog, etc. |
| `time_range` | no | Absolute `from -> to` range or relative range such as `last 5 minutes`. |
| `query` / `filter` | no | Text, error, level, component, correlation ID or other narrowing criteria. |
| `goal` | no | What the caller is trying to understand, e.g. `why did startup fail?`. |

A request may be purely retrieval-oriented (`give me logs from 10:00 to 10:05`) or diagnostic (`find errors from the last five minutes related to startup`).

## Outputs

| Output | Meaning |
| --- | --- |
| `log_report` | Bounded caller-usable report containing the requested/relevant log evidence, source/time/filter context and concise summary when useful. |

The report may include/reference preserved raw diagnostic evidence when useful and permitted, but MUST NOT dump unbounded logs into caller context.

## Prompt / intent scenarios

| Example prompt / intent | Command action | Required inputs / context | Result / notes |
| --- | --- | --- | --- |
| "Give me logs from 10:00 to 10:05" | retrieve time-bounded logs | common context + log source + from/to | log report |
| "Give me logs for the last five minutes" | retrieve relative-time logs | common context + log source + relative time range | log report |
| "Find errors in the logs from the last five minutes" | filtered retrieval | common context + log source + time range + error filter | log report |
| "Why did this service fail to start?" | goal-directed diagnostic retrieval | common context + log source + useful time/context | bounded diagnostic log report |
| "Find logs related to this correlation ID" | correlation-filtered retrieval | common context + log source + correlation ID | log report |

## Result policy

```text
preserve-raw-output: true
result-mode: bounded
```

Return compact/bounded results while preserving/referencing relevant raw diagnostic slices when useful and permitted by runtime storage/privacy limits.

## Intended behavior

- accept bounded retrieval/diagnostic requests;
- select configured logging/observability adapter;
- apply time/service/query filters before returning data;
- understand both absolute and relative time-range requests;
- use caller goal to focus evidence when supplied;
- enforce output/token/line limits;
- preserve provenance to underlying log source;
- preserve/reference raw evidence according to result policy;
- return enough evidence for reasoning without unbounded log exposure.

## Command delegation

| Command | Access | Purpose |
| --- | --- | --- |
|  |  |  |

Commands not listed are not granted.

## TODO

- define `spec.md`;
- refine provider-neutral query inputs/outputs;
- define hard output limits/summarization behavior;
- define adapters such as local logs and Datadog;
- define authorization/privacy/storage boundaries;
- add tests and implementation.