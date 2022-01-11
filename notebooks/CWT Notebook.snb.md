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

So in terms of the results they are coming from different repos, multiple languages, markdown files and xml configuration files.

So in this instance we are using the default search mechanism provided by SG - literal search. SG provides three search mechanisms - literal search, regular expression search and structural search. Using literal string search is great if you have a good idea of the symbol name or phrase you need to look for. And literal search is probably what you are used to using.

Let us take a look at another example. Let us assume that I have to do some troubleshooting. I have an error message that I am not familiar with. If I can search for the error message I can see where in the code the message was generated. And begin to determine the root cause.

Here we have a log file - a Sourcegraph log file in fact - I can see the following error in this file. 

_performing background repo update_

```sourcegraph
performing background repo update patternType:literal
```

### Regular Expression

Let us assume I’m a relatively new member of the team and I have been asked to add a new authentication provider. So I want to search the code base to see if I can find some examples and hopefully get a head start.

So let us use the term

“New Auth Provider”

And stick to using literal search in the first instance.

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal)

```sourcegraph
new auth provider patternType:literal
```

So again I get results from lots of different repos from different code hosts. Because I am using literal search the results I am seeing are from comments in source code and configuration files. And that certainly gives me a starting point.

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
new auth provider lang:go -file:_test\.go$ repo:^github\.com/sourcegraph/.* patternType:regex
```

So now we can see some files which I am confident are really going to be relevant to my task. I can see the number of matches in each file and the files are ordered by star ranking on github. So we have a few comments but if I scroll down I see a file with 11 matches. So this might be worth taking a closer look at. Let us select this file.

[https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go](https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go)

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ file:^enterprise/internal/authz/authz\.go
```

### IDE + Code Intelligence

So now we have a more IDE-like view. We have the file in the main pane. And on the left we have the files that are in the same directory in the repo and also symbols defined in this source code.

In the main pane we provide code intelligence via a hover tooltip. We can see the function definition, comments and we can go to the definition and find references, and that is irrespective whether these are in this repo or a separate repo.

So now rather than searching for code I can use code navigation.

This helps find where a function is used, how it is called. Also help me better understand the impact of changes I might be planning

So let me select references for this function. This brings up another pane show where this function is used, how it is called. I can group by file. And I can look at the history of this file. 

###Commit and Diffs

So here we can see we are not only able to search the source code but we can also search code diffs and commits as well. So not only can I search across a specific snapshot of the codebase, I can also search by time as well. So this helps me find and understand when code changes.

```sourcegraph
NewAuthzProvider repo:^github\.com/sourcegraph/sourcegraph$ type:diff select:commit.diff.added before:"3 months ago" patternType:regexp
```

Let us go back to the code view for a moment.


### Extensions - Gitblame

SG does not live in isolation, it interfaces with a number of technologies to provide developers additional information that will help them better understand their code - so for example what is the test coverage for a file, this might give us some confidence regarding the quality of the code we are looking at.

And in SG we do this through what are called extensions.

Let us take a look at a couple of extensions.

So the first one allows us to view git blame information either for the highlighted line or for the whole file. So now I can see who last changed the line, when it was changed and the commit message associated with the change. This can help me decide if this is code that I have confidence in if I am looking to reuse it.

I can also take a look at the test coverage via a code cov extension. In this particular instance I can see that the coverage is not very good. So this might suggest I should use different code.

We also provide extensions for IDE such as visual studio - allows us to move between SG and our IDE very easily. So for example when I am in my IDE and I want to search I can do it directly from the IDE.

Lastly perhaps our most important extension is our browser extension for the code hosts that we support. This adds SG code intelligence to code and code diffs when viewing them on your code host.

It also allows us to search via sourcegraph via a shortcut from within your browser.


### Structural Search

In terms of search I want to show you the third search mechanism we provide and that is structural search.

​​Structural code search lets you match nested expressions and whole code blocks that can be difficult or awkward to match using regular expressions.

So the structural search mechanism is 

NewAuthzProviders(:[_]) (...) {...} lang:go repo:^github\.com/sourcegraph/sourcegraph$



## Code Search Building Block


### Monitoring

Database vs stream based processing - push v pull


### Code Insights

Tracking Migrations 


* How many repos so far have a specific config file in a specific directory? 
* Tracking the existence of a specific configuration files 

Tracking Adoption


* How many repos/teams are using an API your team built and wants to deprecate?
* Which databases we’re calling or writing to most often?
* How many repos are importing a large/expensive package? 

Tracking Deprecations


* How are we progressing on deprecating tooling that we’re moving off of?
* Are we deprecating a structural code pattern in favor of a more optimized pattern? 


### Batch Changes
