# Sourcegraph for Incident Response

Sourcegraph accelerates the path from **Alert** to **Root Cause**.

## Scenario: root causing an error

The site goes down and your alerting indicates the following log error message:
```
10-06-21 02:31:29 [ERR] Failed to ensure HEAD exists
```

Use Sourcegraph to locate the source of the error across all your code:

```sourcegraph
Failed to ensure HEAD exists
```

Oftentimes, the error message is less specific than you would like:

```
10-06-21 02:31:29 [ERR] unknown network type
```

This search would yield a lot of noisy results. To filter out the noise, you **search through your dependency graph**:

```sourcegraph
r:deps(^github\.com/sourcegraph/sourcegraph$) unknown network type
```

Diving into the code, you have full code navigation capabilities with Sourcegraph's unique [precise code intelligence](https://docs.sourcegraph.com/code_intelligence/explanations/precise_code_intelligence).

https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/cmd/gitserver/server/server.go?L1828-1833

You can add comments and annotations as your investigation proceeds that you can share with others who join the conversation later in the notepad.



You can also use Sourcegraph extensions to see additional context about the code from production monitoring and CI.
* [Codecov](https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/cmd/gitserver/server/server.go?subtree=true)
* [Sentry](https://sourcegraph.com/github.com/sourcegraph/sourcegraph@8d884dbf87571629667d799b2d40f2f3ee00dadf/-/blob/schema/schema.go?L106-110)
* [More extensions](https://sourcegraph.com/extensions)
