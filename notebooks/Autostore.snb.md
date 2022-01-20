# Autostore


[https://sourcegraph.com/search](https://sourcegraph.com/search)

##How and Why do developers and engineers use Code Search?

###Where?
Where a specific piece of information exists in the codebase; for example, a function definition or configuration, all usages of an API, or just where a specific file is in the repository.

###What?
What is the purpose of this part of the codebase? What is it doing?
###How?
How have my colleagues/peers implemented X? Help me find a specific API and help me understand how the API should be applied to a particular problem?
###Why?
Why is the code behaving differently than expected? Target specific versions of the codebase that maybe relevant to a production install.
###Who and When?
Who or when someone introduced a certain piece of code? 

### Incident Tracking

So if I wanted to find some scary code I might run the following search query -

[Here be dragons](https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal)

```sourcegraph
here be dragons lang:C patternType:literal
```

So in this instance we are using the default search mechanism provided by SG - literal search. SG provides three search mechanisms - literal search, regular expression search and structural search. Using literal string search is great if you have a good idea of the symbol name or phrase you need to look for. And literal search is probably what you are used to using.

We will come back to regular expressions in a moment but I just wanted to touch on structural search briefly. Structural search helps you search code for syntactical code patterns like function calls, arguments, if...else statements, and try...catch statements. It's useful for finding nested and recursive patterns as well as multi-line blocks of code. So for example the following is an example of using structural search.

```sourcegraph
fprintf(..., "ERROR: ...", ...) lang:c repo:^github\.com/torvalds/linux$ patternType:structural
```


Let us take a look at another example using literal search. Let us assume that I have to do some troubleshooting. I have an error message that I am not familiar with. If I can search for the error message I can see where in the code the message was generated. And begin to determine the root cause. Here we have a log file - a Sourcegraph log file in fact - I can see the following error in this file. 

_performing background repo update_

```sourcegraph
performing background repo update -file:\.md patternType:literal
```


##Developer Onboarding / Velocity

- creating new function
- reusing existing code
- understanding impact of code changes


### Create New Authentication Function

Let us assume I’m a relatively new member of the team and I have been asked to add a new authentication provider. So I want to search the code base to see if I can find some examples and hopefully get a head start.

So let us use the term

“new auth provider”

And stick to using literal search in the first instance.

[new auth provider](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal)

```sourcegraph
new auth provider patternType:literal
```

But what if we switched to a regular expression search instead?

[new auth provider -regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp)

```sourcegraph
new auth provider patternType:regexp
```

So now I am getting more results from the source code itself. But we are still searching across all repos, can we narrow it down a little? If we look at the left hand side of the search results we can see the  SG has kindly suggested a number of filters that we could use or dynamic filters as they are labelled here. One is I can filter by language. So I know that SG is largely written in GO so it makes sense to only select results from go files.


[new auth provider -go -regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp)

```sourcegraph
new auth provider lang:go patternType:regexp
```

And we also might want to exclude certain files, test files for example, these probably are not going to help me.


[new auth provider -go -test files -regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp)

```sourcegraph
new auth provider lang:go -file:_test\.go$ patternType:regexp
```

And of course I’m only really interested in sourcegraph codebase in this instance so I can add a filter so that we are only looking at certain repos.

[new auth provider -go -test files -sourcegraph -regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp)

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

###	 Adding Context

What if we could add additional information whilst navigating the codebase? This might help us better understand who to discuss potential changes with, what is the test coverage across a particular file and there any concerns in terms of code quality. In Sourcgraph we do this using extensions. 

So for example we can add gitblame information to give us information about the time and author of the last commit.

And I know you use SonarQube. In Sourceraph we can add SonarQube annotations whilst navigating our code.


```sourcegraph
repo:^github\.com/apache/struts$ file:^bundles/admin/src/main/java/org/apache/struts2/osgi/admin/actions/BundlesAction\.java
```

## Code Health

- updating internal / third party components
- monitoring codebase
- tracking changes to the codebase
- automated updates

So being able to find and fix potential bad code patterns is important - it helps improve code quality, reduces bugs, makes our code more readable which is helps improve productivity. 

So as an example lets take a look at use of the latest tag when specifying a docker image. This is an anti-pattern - its non deterministic when trying to build an image. So what if we could find where it occurs in our codebase so that we can make the necessary changes. Furthermore what if we could be alerted when someone introduces or reintroduces this pattern? Would it be useful to track how quicly we are migrating away from this pattern? And what if we could automatically refactor our code?

```sourcegraph
^FROM (\w+\/)?\w+:latest($|\s) file:Dockerfile repo:sourcegraph patterntype:regexp
```

```sourcegraph
type:diff ^FROM (\w+\/)?\w+:latest($|\s) file:Dockerfile repo:sourcegraph select:commit.diff.added patterntype:regexp
```

