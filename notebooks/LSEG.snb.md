# LSEG	

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
new auth provider repo:sourcegraph patterntype:regexp 
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

[New Authz Provider Batch Change](https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider?visible=2)

[Small Tracking Campaign](https://demo.sourcegraph.com/users/malo/batch-changes/small-trackin-campaign)


## Monitor Codebase  

Once we have made our fixes we want to make sure that they don't come back !!

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ newauthzprovider  lang:Go type:diff select:commit.diff.added patterntype:regexp 
```

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
