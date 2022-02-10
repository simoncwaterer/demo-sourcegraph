# Code Reuse

## Introduction

I’m going to show you how Sourcegraph makes it easy to find reusable code, can show you how its usage changes over time and how it can help you automate changes to your shared libraries.

### Proof Points that Support Desired Outcome

#### Vignette 1

##### Tell 

If I can find code that I can reuse I can spend more time writing new code. And also reduce the effort spent on debugging and testing. 

I'm going to show you how we can search for reuseable code but also gain an understanding of the quality of the code based on additional context such as who wrote it, how often it has changed, where it is used and how well it has been tested.

##### Show

Lets imagine I need to connect to a new code host and I need to write a authentication provider. We have done this before so I am to search for an existing authentication provider that I can repurpose. So lets use a regualr expression to search for a pattern in our code.

```sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ new auth provider  patternType:regexp 
```
And if I want to I can just search for symbols defined within the code.

```sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ new auth provider  type:symbol patternType:regexp 
```
I can then select one of the functions and take a look at the source code. 

*select github function as it has better code coverage*

I probably want to know who wrote this, so I can ask questions if I need to. I can do this by including gitblame information for a line or the whole file. In this instance I can see it written by Joe one of our engineers and updated a couple of years ago.
 
*Reference the inline blame, how long ago it was written, who wrote it*

How well has it been tested? I can include information from code coverage tools such as code cov. So in this case it looks like we have pretty good testing coverage for this code.

*toggle CodeCov extension*

It might be useful to understand who else is using this function and how it is being used. Sourcegraph will enable me to find references to this function in this and other repos.

*Find references*

I can also get an understanding on how this code and how it is used has changed over time by searching across commit messages or code diffs. So for example I can easily across code diffs

```Sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ NewAuthzProvider type:diff 
```

Assuming that I now feel confident about reusing this code, I can jump into my editor and begin to work with NewAuthzProviders 

*open in VSCode* 

##### Tell

We have just seen how we can quickly find example code. And how we can easly access additional information to enable me understand how much I can trust this code.  The result being saving myself development effort.

##### Ask

As an Engineer, how do you find whether someone else in the company has written the piece of code that you need before? 
How do you know if it’s “good” code? Signals: how old is it? Is it maintained? Is it tested? Who owns it?



#### Vignette 2


##### Tell

As the maintainer or stakeholder of a library or module I want to help other developers use it. And it would also be useful to be able to track its usage over time.


##### Show

**I can create a notebook to show a new developer all the uses of authz in the code base and guide them to use it from the get-go—live search results mean that they’ll always have real examples to use.**

[New Authz Providers Notebook](https://demo.sourcegraph.com/notebooks/Tm90ZWJvb2s6NA==)

If I want to stay on top of adoption, I can create an insight from the original search and quickly track the growth of authz use in our codebase over the past year.

```Sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ newAuthzProvider patterntype:regexp
```

*Click Create Insight - Show the live preview with the shown increase in use over the past year (no need to actually save the insight)*


##### Tell

We can help new developers explore and understand code through notebooks to enable them to effectively use shared libraries.

I can easily visualize the growth in usage of a shared library to help me understand the time savings and code stability through code reuse.

That will also be helpful in understanding the impact of any planned changes to the library or potentially moving to a another library


##### Ask

How do you identify what code should be extracted into common libraries?
How do you see who’s using a library, and who’s still doing it the old way (reinventing the wheel)?
How do developers discover that there’s some code they can reuse inside your org?



#### Vignette 3

##### Tell

Sourcegraph can help me maintain my shared code and also alert me when someone uses a deprecated library or function.


##### Show 

For example if a naming convention changes I can quickly update the code to use the new convention. We do this using Batch Changes. This Batch Change spec defines what I want to change, how to make the changes and how to push those changes to our code host.

[New Authz Provider Batch Change](https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider?visible=5)

*show batch change spec*

*show changeset example*

I can generate alerts when someone uses a depracated library or function using a code monitor. This code monitor will alert me if someone checks in code using the old naming convention for our function.

[Create new code monitor](https://demo.sourcegraph.com/code-monitoring/new)

*type:diff repo:github.com/sourcegraph/sourcegraph NewAuthzProvider lang:go*


##### Tell

I’ve eliminated the overhead of code maintenance which encourages more code reuse and code stability. Long depreciation cycles are no more, and no more need for tracking spreadsheets.

##### Ask

What’s the most recent instance of code reuse, and how’d it happen?
What are your team’s goals around code reuse or innersourcing?
How do you keep shared libraries and APIs up-to-date across your entire organization?

* * *


## Discovery Questions

1. How important is code reuse viewed within the organisation?
2. How do developers discover that there’s some code they can reuse inside your org? (tools / messaging colleagues)
2. How do you identify what code should be extracted into common libraries? Is it informal bottom-up or top-down?
3. How do you see who’s using a library, and who’s still doing it the old way (reinventing the wheel)?
4. What’s the most recent instance of code reuse, and how’d it happen?

## Sourcegraph Differentiation - traps

1. The Code is source of truth and work in conjunction with runtime tools such AppDynamics in determing library/API usage
2. How can you track changes to libray / API usage over time?
3. How would you push updates to a library/API across a codebase?



Value Statement

Improving code reusability is an objective for many engineering organisations. 
reduce effort in terms of developing code but also debugging and testing code. The goal is to enable product teams to reduce time to market, release new capabilities more quickly and improve wih higher quality.

Happy to take any questions or comments on what we have just seen. And from my perspective I would be interested to understand how you ..... ????

Code reuse has many benefits. Most obviously, you don't have to write so much code. However, it also has other benefits, which are perhaps more important, as identified:

•
Better readability of code. Extracting classes and methods when opportunities arise has the effect of reducing the size of methods, or blocks of code, making them easier to understand. This has the additional benefit of making it more likely that certain errors or inefficiencies will be noticed at the time of code writing.

•
Better structure of code. Refactoring improves the structure of code, and the avoidance of duplication (through extracting methods) makes code more maintainable as any modifications in the future only need to be applied in one place; this also prevents inconsistency creeping in through incremental updates where there are multiple sections of code where changes need to be synchronized.

•
Reduced testing effort. The reuse of code blocks, which have already been unit tested, saves testing effort, both in terms of avoiding the need to write additional tests and also by not having to run those additional tests each time the full test suite is run.

Code reuse is one of the use cases where we believe Sourcegraph can add a lot of value. There are two aspects to code reuse. The first is with respect to finding code to reuse, can I find a function or class that I can reuse or at least give me a headstart, can I see how others have used a function or API by finding example code? And when I do find code to reuse should I reuse this code? Who wrote it, how often has it been updated, do I have information on test coverage and who else is using might be good inidcators?

The second aspect is once I have created a library which is being reused how can I track where its being used within a codebase? Perhaps I need to make some change, an endpoint perhaps, and I want to understand who might be impacted so I can communicate the changes they need to make? Or who is using an older version of my library which has some bug which has been fixed?

* Currently what is your approach to identifying code that can reused or finding example code? 
* How do you identify where internal or third party libraries are being used?

It might be useful to run through a code reuse scenario using Sourcegraph. Lets assume I'm a Sourcegraph engineer. As you know Sourcegraph intergrates with a number of code hosts. And as part of that integration we need to authenticate with a code host. Lets assume that a client is using a code host that we are not currently integrated with. And my task is to write the code to perform authentication. So we have done this before I can probably find some example code or indeed an interface that I should use.

So how might I do that with Sourcegraph?

```Sourcegraph
new auth provider lang:go repo:^github\.com/sourcegraph/sourcegraph$ -file:test patterntype:regexp
```

select - symbol
diff
gitblame
code intell




references - code intel
search - starting blank canvas
best practice - API/Library - code pattern go/switch case
New Auth
hashmap - example API - netflix
switch go statement
https://docs.google.com/document/d/1imSKse0-0QLqsx4hDgKcwxWTwcPXs_wGthbBNKQZvKA/edit#heading=h.ygxngsyszq51

https://sourcegraph.com/search?q=repo:%5Egithub%5C.com/golang/go%24+switch+:%5B%5Bv%5D%5D+:%3D+:%5Bx%5D.%28type%29+%7B:%5B_%5D+case+nil:+:%5B_%5D%7D+lang:go+&patternType=structural

spark API - 

hashmap - usafe putifAbsent
https://sourcegraph.com/github.com/Netflix/Hystrix/-/blob/hystrix-core/src/main/java/com/netflix/hystrix/HystrixRequestCache.java?L80:51#tab=references

notebooks ?
apache nifi or apache spark?

I can find code my teammates have written to avoid duplication and save myself hours redoing work that’s already been done and spend my time writing new code. Plus, if the existing code is already tested, I can rely on those existing tests for stability and security of the code I want to implement. 

Improving code reusability is an objective for many engineering organisations. The goal is to enable product teams to reduce time to market, release new capabilities more quickly and improve wih higher quality.


