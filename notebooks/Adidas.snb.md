# Adidas



[https://sourcegraph.com/search](https://sourcegraph.com/search)


## Search Contexts

A search context represents a set of repositories at specific revisions on a SG instance. It is one way to target a specific search scope. So for example I could create a search context that targets my frontend code.

## Introduction to Search

Lets find some scary code

```sourcegraph
here be dragons lang:c repo:^github\.com/torvalds/linux$ patternType:literal
```

SG provides three search methods

* literal search
* regular expression search
* structural search

Using literal string search is simple to use - its probably what you are used to using already !!


### Incident Response

```sourcegraph
repo:^github\.com/simoncwaterer/demo-sourcegraph$ file:^notebooks/sourcegraph\.log
```

```sourcegraph
performing background repo update lang:go patternType:literal
```

## Developer Onboarding

* What are the best practices?
* Where are things located? How are they organized?
* What should I be looking out for?
* What anti-patterns should I avoid?

How do manage ***actors*** within Sourcegraph code ?

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ lang:Go (actor.WithActor(...) OR actor.WithInternalActor(...)) -f:mock|_test patternType:structural
```

We could include the source code in a wiki but ....

We could share this query with out colleagues but ....

Sourcegraph Notebooks allow you to highlight and detail patterns, anti-patterns, good practice and dev/eng processes.

[Sourcegraph Notebooks](https://sourcegraph.com/notebooks?tab=explore)

[Actor Propagation](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6OTI=)


## Code Reuse

Find code to reuse or repurpose enables to spend more time writing new code, less time debugging and testing. 

### Find Code

* How to find code to reuse?
* Is it *good* code?
* Who wrote it?
* Is it stable?
* Has it been tested?
* How do I use it?
* How has it evolved?

Connect to a new code host - we have done this before !!

```sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ new auth provider -file:test lang:go patternType:regexp 
```

```sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ new auth provider -file:test lang:go type:symbol patternType:regexp 
```

### Enablement

* How can I help my teammates make use of library / API?
* Is it "successfull"?



[New Authz Providers Notebook](https://demo.sourcegraph.com/notebooks/Tm90ZWJvb2s6NA==)


```Sourcegraph
context:global repo:^github\.com/sourcegraph/sourcegraph$ NewAuthzProvider patternType:regexp
```

### Maintain

* How can we make changes to our shared code across the organisation?
* Can I track if somone is using a deprecated function or API?


[NewAuthzProvider Batch Change] (https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider)

[Create new code monitor](https://demo.sourcegraph.com/code-monitoring/new)

```sourcegraph
type:diff repo:github.com/sourcegraph/sourcegraph NewAuthzProvider lang:go patterntype:regexp
```


# Misc ignore 



### Circle CI Pipeline


If we are using a CI pipeline and we want to updated a particular docker image how can we determine the impact of the change? What repos and files are effected? Lets try and find the impacted files. 

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node patterntype:regexp
```

And just looking at facebook repos

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node repo:facebook patterntype:regexp
```

and NewsUK repos

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node repo:newsuk patterntype:regexp
```

####Monitor Code Changes

Now if I look at the documentation it appears that this image has now been replaced by another image - circleci/node:tag -> cimg/node:tag. Perhaps I want to know if anyone makes an update to a pipeline and adds the old image - it would be useful to be notified. With sourcegraph we can use search as a platform to enable us to monitor changes in the code base through code monitoring.


```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node repo:^github\.com/newsuk type:diff select:commit.diff.added  patternType:regexp
```

