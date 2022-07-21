# IAG

# Search 101

3 search modes

* literal
* regex
* structural

Filters that help us define scope of search 

* repos
* languages
* branches
* what we want to search
* type of results to return

```sourcegraph
here be dragons lang:C repo:^github\.com/torvalds/linux$ 
```

```sourcegraph
repo:^github\.com/torvalds/linux$ lang:C fprintf(stderr, "ERROR: ...", strerror(...)) patterntype:structural 
```

```sourcegraph
repo:^github\.com/apache/.* lang:Java count:2000 class ... extends AsyncTask<...> {... @Override protected Integer doInBackground(...) ...} patterntype:structural 
```

# Code Reuse

## New Authentication Provider

Let us assume we are a new engineer at Sourcegraph and we have been tasked to create a new code host authentication. We have done this before of course, so hopefully we can find some code to reuse or repurpose in some way.

We will see how we can quickly find relevant code, narrow down our search scope and filter the results that are of interest.

```sourcegraph
new auth provider patterntype:regexp 
```

## Understand Code 

Add context to code to better understand quality, for example

* Who wrote it
* How has the code changed
* Is it stable
* Where is it used
* How is it used
* Add 3rd party context - code quality, test coverage

https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/github/authz.go?L30-40

## Interactive Documentation

Let us assume we have created a module or library that others in my organisation can reuse. As the maintainer or stakeholder of a library or module how can I help my teammates use this code more effectively? 

Single Document combining

* text
* diagrams
* live code search
* source code

Objective is to help developers collaborate more effectively. 

[Authz Notebook](https://demo.sourcegraph.com/notebooks/Tm90ZWJvb2s6NA==)

[Actor Propogation](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6OTI=)

## Visualize Codebase
How well is my library performing? In terms of its use by others in the codebase. We can use search as the basis for creating trends across our codebase.

[New Auth Code Insight](https://demo.sourcegraph.com/insights/insight/aW5zaWdodF92aWV3OiIyOG5rbTR2TEdZZmt4NExIdTd1c3FoWXpqZTci)

## Refactor API
How can we automate changes to our shared code? Lets see how we can create a batch change to automate changes to a function name. Confirm that the changes are correct. And then monitor the status of the pull or merge request on the code host. Lets assume a naming convention has changed meaning that we need to rename our function newAuthzProvider.

Goal is to decrease development effort and errors, and allow developers to focus on higher value work.

https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider?visible=2

https://demo.sourcegraph.com/users/malo/batch-changes/small-trackin-campaign

## Monitor Codebase  

Once we have made our fixes we want to make sure that they don't come back !!

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ newauthzprovider  lang:Go type:diff select:commit.diff.added patterntype:regexp 
```

# Code Health

## Importance of Code Health

*Minimizing technical debt and improving code health, in terms code readability, simplicity, how easy code is to test and build, is a key objective for most organisation.*

The impact of technical debt and poor code health is

* missed deadlines
* reduced application quality

A McKinsey survey reported that up to 20 percent of budget is spent resolving issues related to tech debt. But that tech debt might amount to up to 40 percent of the value of their codebase.

[McKinsey Reclaiming Tech Equity](https://www.mckinsey.com/business-functions/mckinsey-digital/our-insights/tech-debt-reclaiming-tech-equity)

## Sourcegraph and Code Health

Today we will look at three Code Health examples:

* Migration of a coding construct
* Monitoring code cleanliness
* Tracking the prescense of test harnesses within the code

## Code/Component Migration

Whenever a decision is made to move from one library, framework or language to another its vital to be able to track progress. Without that proper planning and management is hard.

Let us use Sourcegraph to help us understand the 

* number of class components in the codebase
* export data I can use to assign work to team members using Jira tickets for example
* create a chart that helps me track overall project progress
* and finally create an alert to inform me if someone adds a class component

### React Migrate Class to Function Components

[React Insight](https://demo.sourcegraph.com/insights/edit/aW5zaWdodF92aWV3OiJzZWFyY2hJbnNpZ2h0cy5pbnNpZ2h0LmRpcmVjdG9yeS5yZWFjdEZ1bmN0aW9uQ29tcG9uZW50TWlncmF0aW9uIg==?dashboardId=ZGFzaGJvYXJkOnsiSWRUeXBlIjoiY3VzdG9tIiwiQXJnIjo3NDUzNn0=)

```sourcegraph
repo:^(github\.com/sourcegraph/sourcegraph)$ extends\s(React\.)?(Pure)?Component patterntype:regexp 
```

```sourcegraph
repo:^(github\.com/sourcegraph/sourcegraph)$ const\s\w+:\s(React\.)?FunctionComponent patternType:regexp 
```

```sourcegraph
repo:^(github\.com/sourcegraph/sourcegraph)$ extends\s(React\.)?(Pure)?Component type:diff patterntype:regexp 
```

## Code Cleanliness  

Adding a TODO comment in your code can be a convenient placeholder for a future update. The intention is to increase quality of code. But they can often be left there and become out of date. And can then end up being a distraction.

Let us see how Sourcegraph can track the growth of TODOs across our codebase.

We will see 

* how we can track the number of TODOs over time
* track the number TODOs added
* and finally track the number TODOs removed

[Todos in Sourcegraph Repo](https://demo.sourcegraph.com/insights/edit/aW5zaWdodF92aWV3OiIyNFFyWkd3d0FhY2JNSldVekpLOGI4MjhuaXoi?dashboardId=ZGFzaGJvYXJkOnsiSWRUeXBlIjoiY3VzdG9tIiwiQXJnIjo3NDU5NH0=)

```sourcegraph
TODO repo:github.com/sourcegraph/src-cli
```

```sourcegraph
TODO repo:github.com/sourcegraph/src-cli type:diff select:commit.diff.added
```

```sourcegraph
TODO repo:github.com/sourcegraph/src-cli type:diff select:commit.diff.removed 
```

## Testing Coverage 

Are we following best practice that our engineering organisation has put in place? 

Here we have four different queries that are helping me track different tests: 

* end-to-end
* regression
* backend integration
* client integration

```sourcegraph
patternType:regexp case:yes \b(it|test)\( f:/end-to-end/.*\.test\.ts$
```

[Number of tests](https://demo.sourcegraph.com/insights/edit/aW5zaWdodF92aWV3OiJzZWFyY2hJbnNpZ2h0cy5pbnNpZ2h0LmUyZVRvSW50ZWdyYXRpb25UZXN0c01pZ3JhdGlvbiI=?dashboardId=ZGFzaGJvYXJkOnsiSWRUeXBlIjoiY3VzdG9tIiwiQXJnIjo3NDU5NH0=)

# Fix Vulnerabilities Demo

Almost 22,000 vulnerabilities were published in 2021.  The mean time to remediation for high risk vulnerabilities is 84 days.

Let us see how Sourcegraph can help us with the following:

* how we can find code affected by the an identified vulnerability
* how we visualize the vulnerabilities across the codebase over time
* how we automate changes to our code to fix the vulnerability
* and finally how we can generate alerts if a vulnerability is reintroduced.

## Find Effected Code

Let us start with finding effected code within our codebase. We will see how easy it is to search the codebase, share results and also create a notebook to document our investigation.

Let us start with running the following regex search on the codebase.

Here we can see a number of results very quickly from multiple code hosts and multiple repositories

I could share the search query. I could save the search query. I could export the results to a CSV file and use this to assign tasks to relevant development teams.

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) patterntype:regexp 
```

## Share Investigation

Or we could use what we call a notebook to share our investigation with team members. A notebook combines code search, code snippets and markdown text into a single document. Here is one we created for log4j.

[Log4j Notebook](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6MQ==)

## Visualize Code at Risk

We have found the code at risk. And the intent is to fix the problem. In this instance we want to replace vulnerable versions of log4j with patched versions. What if I could visualize how how the codebase is changing over time with respect to a particular security issue we are working on?

We do this in Sourcegraph using what we call code insights.

[Log4j Migration Insight](https://demo.sourcegraph.com/insights/insight/aW5zaWdodF92aWV3OiIyM3pHaDY3bktIUEF3WU44ZkpGNXRWNVI3dUki)

## Automate Code Changes  

We want to update our code to remove the log4j vulnerability, we need to update the log4j versions we are using across all our repos.

Let us see how Sourcegraph can enable us to automate these changes. Allowing our developers and engineers to focus on higher value work. We do this in Sourcegraph using the batch change capability. Here is one we have created for the Log4j issue.

[Log4j Batch Change](https://demo.sourcegraph.com/users/dan.diemer/batch-changes/upgrade-log4j-2.17-gradle?tab=spec)


Now in this example we have a small number of changesets - we are not that impacted by log4j - but lets take a look at much larger example.

[Malo Medium Tracking](https://demo.sourcegraph.com/users/malo/batch-changes/medium-trackin-campaign)

## Monitor Codebase  

Once we have made our fixes we want to make sure that they don't come back. Let us create a code monitor that will alert us if a vulnerable log4j version is added.

If we run our search again - this type we will run a diff - we can see that we can create a code monitor from the search results.

A code monitor enables us to create an alert if code is committed which triggers the search parameters. When the trigger is fired we can figure an alert via email, webhook or slack.

[Log4j Code Monitor](https://demo.sourcegraph.com/code-monitoring/new?q=context%3Aglobal+lang%3Agradle+org%5C.apache%5C.logging%5C.log4j%5B%27%22%5D+2%5C.%280%7C1%7C2%7C3%7C4%7C5%7C6%7C7%7C8%7C9%7C10%7C11%7C12%7C13%7C14%7C15%7C16%29%28%5C.%5B0-9%5D%2B%29+type%3Adiff&patternType=regexp&trigger-query=context%3Aglobal+lang%3Agradle+org%5C.apache%5C.logging%5C.log4j%5B%27%22%5D+2%5C.%280%7C1%7C2%7C3%7C4%7C5%7C6%7C7%7C8%7C9%7C10%7C11%7C12%7C13%7C14%7C15%7C16%29%28%5C.%5B0-9%5D%2B%29+type%3Adiff+patterntype%3Aregexp)

# Sourcegraph for Incident Response
Sourcegraph accelerates the path from Alert to Root Cause.

#Scenario: root causing an error
The site goes down and your alerting indicates the following log error message:

10-06-21 02:31:29 [ERR] Failed to ensure HEAD exists
Use Sourcegraph to locate the source of the error across all your code:

```sourcegraph
Failed to ensure HEAD exists
```

Oftentimes, the error message is less specific than you would like:

```
10-06-21 02:31:29 [ERR] unknown network type
```

This search would yield a lot of noisy results. To filter out the noise, you **search through your dependency graph:**

```sourcegraph
r:deps(^github\.com/sourcegraph/sourcegraph$) unknown network type
```

Diving into the code, you have full code navigation capabilities with Sourcegraph's unique [precise code intelligence](https://docs.sourcegraph.com/code_intelligence/explanations/precise_code_intelligence).

https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/cmd/gitserver/server/server.go?L1828-1833
