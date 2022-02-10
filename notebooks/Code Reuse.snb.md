# Code Reuse


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

## Talk Track

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

Scenario to demonstrate use case
I’m going to show you how Sourcegraph makes it easy to find reusable code, understand its usage trends over time, and how simple it is to safely maintain shared libraries. 
Proof Points that Support Desired Outcome
Vignette 1:
Tell: I can find code my teammates have written to avoid duplication and save myself hours redoing work that’s already been done and spend my time writing new code. Plus, if the existing code is already tested, I can rely on those existing tests for stability and security of the code I want to implement. 
Show: 
I’m going to search for an auth provider implementation that I can repurpose for my own work using regex for a fuzzy match 
context:global repo:^github\.com/sourcegraph/sourcegraph$ new auth provider  patternType:regexp 
I can also add type:symbol to return a list of symbols
I probably want to know who built this, and who can ask about this if I need to 
Reference the inline blame, how long ago it was written
Where else is it being used?
Find references
It might even be useful to see what’s the most recent context/usage around this code
Diff search
Is it tested? 
Toggle the CodeCov extension
After all the understanding I’ve easily gathered now, I can jump into my editor and begin to work with NewAuthzProviders 
Open in VSCode 
Tell: I quickly found example code I can trust for reuse, saving myself time and reinforcing the culture of code reuse while following standard practices in my organization.
Ask: 
Dev: As an Engineer, how do you find whether someone else in the company has written the piece of code that you need before? 
How do you know if it’s “good” code? Signals: how old is it? Is it maintained? Is it tested? Who owns it?

Vignette 2:
Tell: As the maintainer or stakeholder of this code, I want to understand its usage over time and track its growth within the team. I also want to encourage its use by other teammates. 
Show: 
Create a notebook to show a new developer all the uses of authz in the code base and guide them to use it from the get-go—live search results mean that they’ll always have real examples to use. 
Notebook: https://demo.sourcegraph.com/notebooks/Tm90ZWJvb2s6NA== 
If I want to stay on top of adoption, I can create an insight from the original search and quickly track the growth of authz use in our codebase over the past year.
Search
Click Create Insight
Show the live preview with the shown increase in use over the past year (no need to actually save the insight)
Tell: I can easily understand the growth in popularity of this shared library and call out distinct time savings and code stability thru code reuse. I can easily see how large of an undertaking it would be to move to another library instead of this one if we ever are considering doing so.
Ask: 
How do you identify what code should be extracted into common libraries? Is it informal bottom-up or top-down?
How do you see who’s using a library, and who’s still doing it the old way (reinventing the wheel)?
How do developers discover that there’s some code they can reuse inside your org?




Vignette 3: 
Tell: Sourcegraph enables me to reliably and efficiently maintain the code that is being reused in my org. 
Show: Naming conventions change, or something more complex, and I can quickly update all of the places where this common code is used to the new convention, and ensure we are alerted on any use of the outdated convention. 
Batch change to update all the references to the original naming convention
https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider?visible=5
Create a code monitor with the same query to be alerted on any new commits using newAuthzProvider 
Trigger: newAuthzProvider lang:go
Tell: I’ve eliminated the overhead of code maintenance which encourages more code reuse and code stability. Long depreciation cycles are no more, and no more need for tracking spreadsheets.
Ask: 
What’s the most recent instance of code reuse, and how’d it happen?
What are your team’s goals around code reuse or innersourcing?
How do you keep shared libraries and APIs up-to-date across your entire organization?


