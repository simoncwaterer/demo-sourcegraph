# New Auth Provider Script


## Introduction - Big Code

_High level overview of Sourcegraph mission, use cases and value. Obviously this may be provided by the AE. Even if this is not the first meeting, not everyone on the call may have attended previous meetings and a quick refresher may still be useful._

Outline what we are going to go through today

So in this session I am planning to show you the following:



* How we can use Sourcegraph to search across all of your code, regardless of repository and code host
* How we can then use search as a platform to provide insights into the codebase and automate code changes.

Before we begin we take a look at the SG platform, I just wanted to spend a couple of moments outlining the problems and challenges SG are helping companies to overcome.

The need to be world class at developing software is strategic for the majority of organisations. It’s critical to be able to innovate and then accelerate delivery to both internal and external customers.

But one of the challenges is the increasing complexity facing most engineering organisations -



* More developers producing 
* More code that is distributed
* Across a larger number of code repositories and is developed using
* An increasing variety of development languages

It is easy for developers to lose flow and it is harder to understand their codebase.

This impacts daily activities, such as:



* How quickly can new team members be onboarded?
* How easy is it to find example code to understand how an API or functions is used
* Can we find and reuse existing code?
* Do we know which package and library versions are in use?
* Can we track down the code responsible for error and security issues?
* How can we get an understanding of the impact of potential code changes?

The result is that developers and engineers spend most of their time --around 75% or more--is trying to better understand the code. Not writing new code, or modifying existing code.

We believe what is needed is to provide a way for developers to be able to find and understand all their code. One that is integrated with other development tools, and can scale for the largest enterprises.


## SG Platform

So Sourcegraph is a platform that:



1. Enables developers to find code across all repositories, code hosts, languages, history and branches. To enable them to search code, commit messages and code diffs.
2. Add information to help developers better understand code - 
    1. Where is this API implemented?
    2. Where else is it called?
    3. Who owns it?
    4. When was it last changed?
3. Allow teams to automate large scale code refactors

And we will see that SG interfaces and integrates with many of the development tools that your team may be using today.

Of course this includes code hosts such as Github and Gitlab, regardless if these are self hosted or cloud based. But also tools such as IDEs and coverage tools. We’ll take a look at some of these during the platform overview.

So let us jump in and take a look at the capabilities of SG and see how development teams can use the platform.


## Product Tour - Google Search Bar

[https://sourcegraph.com/search](https://sourcegraph.com/search)

So this is the browser based UI for sourcegraph. As you can see at first glance it is similar to Google or other search engines.


### Deployment

Now in this instance I am using a public SG instance at sourcegraph.com. Our clients either use a managed instance that we deploy and run for them, or run their own instance on public or private cloud infrastructure. From a deployment perspective we provide support for kubernetes and also docker compose.

Anyone can use the public instance to search over 2M public repositories on Github and Gitlab. And you can add your own public repositories. So we can search across all these repos - the code, code diffs and commit messages.


### ~~Monitoring, Batch Changes, Extensions~~

~~We are going to focus on search provided by the platform but at the top left of the page we can see other capabilities - code monitoring and batch changes for example - we will touch on them a little later.~~

Looking below the search bar I can see a history of searches that I have run and repos that I have visited.


### Search Contexts

Looking at the search bar on the left I can see a drop down labelled context. A search context represents a set of repositories at specific revisions on a SG instance that will be targeted by the search queries I execute. So for example I could create a search context that targets my frontend code.


# 


# Search walk through

Let us find some code.


### Literal Search

So if I wanted to find some scary code I might run the following search query -

“Here be dragons”

[https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal](https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal)

So in terms of the results they are coming from different repos, multiple languages, markdown files and xml configuration files.

So in this instance we are using the default search mechanism provided by SG - literal search. SG provides three search mechanisms - literal search, regular expression search and structural search.

Using literal string search is great if you have a good idea of the symbol name or phrase you need to look for. And literal search is probably what you are used to using.

Let us take a look at another example. Let us assume that I have to do some troubleshooting. I have an error message that I am not familiar with. If I can search for the error message I can see where in the code the message was generated. And begin to determine the root cause.

Here we have a log file - Sourcegraph log file in fact I can see the following error in this file. 

_performing background repo update_

But if you are not sure what you are trying to find, it is more of a discovery process - perhaps a little hit and miss, then using regular expression search is a great option. Let us take a look at this now.


### Regular Expression

Let us assume I’m a relatively new member of the team and I have been asked to add a new authentication provider. So I want to search the code base to see if I can find some examples and hopefully get a head start.

So let us use the term

“New Auth Provider”

And stick to using literal search in the first instance.

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal)

So again I get results from lots of different repos from different code hosts. Because I am using literal search the results I am seeing are from comments in source code and configuration files. And that certainly gives me a starting point.

But what if we switched to a regular expression search instead?

“New Auth Provider” + regex

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp)

So now I am getting more results from the source code itself. But we are still searching across all repos, can we narrow it down a little?

If we look at the left hand side of the search results we can see the  SG has kindly suggested a number of filters that we could use or dynamic filters as they are labelled here. One is I can filter by language. So I know that SG is largely written in GO so it makes sense to only select results from go files.

“New Auth Provider” + regex + lang:go

[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp)

And we also might want to exclude certain files, test files for example, these probably are not going to help me.

“New Auth Provider” + regex + lang:go -file:_test\*.go$

[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp)

And of course I’m only really interested in sourcegraph codebase in this instance so I can add a filter so that we are only looking at certain repos.

“New Auth Provider” + regex + lang:go -file:_test\*.go$ + repo

[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp)

So now we can see some files which I am confident are really going to be relevant to my task. I can see the number of matches in each file and the files are ordered by star ranking on github. 

So we have a few comments but if I scroll down I see a file with 11 matches. So this might be worth taking a closer look at. Let us select this file.

repo:^github\.com/sourcegraph/sourcegraph$ file:^enterprise/internal/authz/authz\.go

[https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go](https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go)


### IDE + Code Intelligence

So now we have a more IDE-like view. We have the file in the main pane. And on the left we have the files that are in the same directory in the repo and also symbols defined in this source code.

In the main pane we provide code intelligence via a hover tooltip. We can see the function definition, comments and we can go to the definition and find references, and that is irrespective whether these are in this repo or a separate repo.

So now rather than searching for code I can use code navigation.

This helps find where a function is used, how it is called. Also help me better understand the impact of changes I might be planning

So let me select references for this function. This brings up another pane show where this function is used, how it is called. I can group by file. And I can look at the history of this file. 

So here we can see we are not only able to search the source code but we can also search code diffs and commits as well. 

So not only can I search across a specific snapshot of the codebase, I can also search by time as well. So this helps me find and understand when code changes.

Let us go back to the code view for a moment.


### Extensions

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


# 


# Not Just Search


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


### Summary / Wrap Up



Appendix

If you can improve developers' ability to understand code, you stop the Big Code cycle and regain control. Let's make this concrete.

Google facebook

At Sourcegraph our goal is to help development and engineering teams tame this complexity by enabling them to search all of their code regardless of code host or repository. 

Companies find that code search has a number of benefits, these include 



* onboarding new team members faster
* increasing developer productivity
* improving collaboration across teams
* Tracking down security issues more quickly
* Catching more bugs with better code reviews

But ultimately helping them produce better quality code more quickly.

Help everyone code

Improve collaboration

Increase Developer velocity what does that mean 

Onboarding 

Troubleshooting

Find example code

Code reuse


