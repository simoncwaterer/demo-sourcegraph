# CWT Notebook


## Product Tour

[https://sourcegraph.com/search](https://sourcegraph.com/search)

So this is the browser based UI for sourcegraph. As you can see at first glance it is similar to Google or other search engines.


### Deployment

Now in this instance I am using a public SG instance at sourcegraph.com. Our clients either use a managed instance that we deploy and run for them, or run their own instance on public or private cloud infrastructure. From a deployment perspective we provide support for kubernetes and also docker compose.

Looking below the search bar I can see a history of searches that I have run and repos that I have visited.

### Search Contexts

Looking at the search bar on the left I can see a drop down labelled context. A search context represents a set of repositories at specific revisions on a SG instance that will be targeted by the search queries I execute. So for example I could create a search context that targets my frontend code.


## Search walkthrough

### Literal Search

So if I wanted to find some scary code I might run the following search query -

“Here be dragons”

[https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal](https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal)

```sourcegraph
here be dragons patternType:literal
```

So in this instance we are using the default search mechanism provided by SG - literal search. SG provides three search mechanisms - literal search, regular expression search and structural search. Using literal string search is great if you have a good idea of the symbol name or phrase you need to look for. And literal search is probably what you are used to using.

####Incident Tracking
Let us take a look at another example. Let us assume that I have to do some troubleshooting. I have an error message that I am not familiar with. If I can search for the error message I can see where in the code the message was generated. And begin to determine the root cause. Here we have a log file - a Sourcegraph log file in fact - I can see the following error in this file. 

_performing background repo update_

```sourcegraph
performing background repo update patternType:literal
```

### Regular Expression

Let us assume I’m a relatively new member of the team and I have been asked to add a new authentication provider. So I want to search the code base to see if I can find some examples and hopefully get a head start.

So let us use the term

“new auth provider”

And stick to using literal search in the first instance.

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal)

```sourcegraph
new auth provider patternType:literal
```

But what if we switched to a regular expression search instead?

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp)

```sourcegraph
new auth provider patternType:regexp
```

So now I am getting more results from the source code itself. But we are still searching across all repos, can we narrow it down a little?

If we look at the left hand side of the search results we can see the  SG has kindly suggested a number of filters that we could use or dynamic filters as they are labelled here. One is I can filter by language. So I know that SG is largely written in GO so it makes sense to only select results from go files.


[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp)

```sourcegraph
new auth provider lang:go patternType:regexp
```

And we also might want to exclude certain files, test files for example, these probably are not going to help me.


[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp)

```sourcegraph
new auth provider lang:go -file:_test\.go$ patternType:regexp
```

And of course I’m only really interested in sourcegraph codebase in this instance so I can add a filter so that we are only looking at certain repos.

[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp)

```sourcegraph
new auth provider lang:go -file:_test\.go$ repo:^github\.com/sourcegraph/.* patternType:regexp
```

So now we can see some files which I am confident are really going to be relevant to my task. I can see the number of matches in each file and the files are ordered by star ranking on github. So we have a few comments but if I scroll down I see a file with 11 matches. So this might be worth taking a closer look at. Let us select this file.

[https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go](https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go)

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ file:^enterprise/internal/authz/authz\.go
```

### IDE + Code Intelligence

So now we have a more IDE-like view. We have the file in the main pane. And on the left we have the files that are in the same directory in the repo and also symbols defined in this source code. In the main pane we provide code intelligence via a hover tooltip. We can see the function definition, comments and we can go to the definition and find references, and that is irrespective whether these are in this repo or a separate repo.

### Commit and Diffs

So here we can see we are not only able to search the source code but we can also search code diffs and commits as well. So not only can I search across a specific snapshot of the codebase, I can also search by time as well. So this helps me find and understand when code changes.

```sourcegraph
NewAuthzProvider repo:^github\.com/sourcegraph/sourcegraph$ type:diff select:commit.diff.added before:"3 months ago" patternType:regexp
```

### Sourcegraph Extensions - Gitblame

SG does not live in isolation, it interfaces with a number of technologies to provide developers additional information that will help them better understand their code - so for example what is the test coverage for a file, this might give us some confidence regarding the quality of the code we are looking at.

And in SG we do this through what are called extensions.

### Structural Search

​​Structural code search lets you match nested expressions and whole code blocks that can be difficult or awkward to match using regular expressions.

```sourcegraph
try {:[_]} catch (:[e]) { } finally {:[_]} lang:java patterntype:structural
```


## Code Search Building Block


### Monitoring

Database vs stream based processing - push v pull

### Code Insights

* Tracking Migrations 
* Tracking Adoption
* Tracking Deprecations

[https://demo.sourcegraph.com/insights/dashboards/all](https://demo.sourcegraph.com/insights/dashboards/all)

### Batch Changes

Automate code and configuration changes

[https://demo.sourcegraph.com/batch-changes](https://demo.sourcegraph.com/batch-changes)

```sourcegraph
^FROM (\w+\/)?\w+:latest($|\s) file:Dockerfile patterntype:regexp
```