# NewsUK

Two use cases and scenarios

## The Challenge of Onboarding

How can we help developers onboard more quickly and efficiently? Whether that is a new starter or someone moving between teams of projects. We want new developers to start contributing as quickly as possible - it is good for them and the developer organisation as a whole. A complex and growing codebase makes this a challenge. And how can we do it without impacting the existing team members?

## Fixing Vulnerabilities

Almost 22,000 vulnerabilities were published in 2021. The mean time to remediation for high risk vulnerabilities is 84 days. Log4j was a recent headline issue at the end of 2021. Its important for organisations to be able to find and fix these issues as effciently as possible. We obviously want to remove risks to ourselves and our customers and also reduce the impact on other work.

## Demo Roadmap

Today we will run through the following - 

* how we can collaborate more effectively using documentation tied to our the code
* how we can find easily find relevant code
* how we can then better understand that code
* how we visualize how our codebase changes over time
* how we can automate changes to our code

# Understanding Best Practice

As a new developer, one of the hardest tasks is learning about best practices, coding standards and programming patterns within the team. So for example how do we use frameworks and libraries, how does our CI /CD pipeline work, are there standards with respect to documentation and testing.

If I have a good understanding of best practice it will help ensure that when I do start commiting code; code reviews will progress more smoothly.

Let me show you how we can help developers accelerate their undertanding using Sourcegraph Notebooks.

We will see how a Sourcegraph notebook combines markdown text, live code search and code snippets into a single living document. They are inspired by Jupyter notebooks which are commonly used within data science.

The objective is to help developers and engineers to share information about a codebase with the goal of increasing developer productivity, improving code health and reducing technical debt. Notebooks help new devs self-serve, freeing up your valuable resources.

[Actor Propagation](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6OTI=)

The Sourcegraph platform is built using Go. Within the platform a framework of actors is used to help manage concurrency. This notebook outlines how context is propagated both within Sourcegraph services and between multiple services.

# Find Code

## New Authentication Provider

Let us assume we are a new engineer at Sourcegraph and we have been tasked to create a new code host authentication. We have done this before of course, so hopefully we can find some code to reuse or repurpose in some way. 

We will see how we can quickly find relevant code, narrow down our search scope and filter the results that are of interest.

```sourcegraph
new auth provider patterntype:literal 
```

```sourcegraph
new auth provider repo:^github\.com/sourcegraph/sourcegraph$ lang:Go type:symbol patterntype:regexp 
```

## Find Vulnerability

If we take a look at another scenario how can we find what code is affected by a know vulnerability. In this case we will use the Log4j vulnerability that was discovered in 2021.

We will see how we can

* find affected code
* share results
* create a notebook to document our investigation


In this particular case we are looking for at risk log4j versions with gradle files.

Here we can see a number of results very quickly from multiple code hosts and multiple repositories

I could share the search query. I could save the search query. I could export the results to a CSV file and use this to assign tasks to relevant development teams.

### Gradle

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) patterntype:regexp 
```

### Maven

```sourcegraph
<log4j\.version>2\.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))</log4j\.version>
file:pom\.xml patterntype:regexp count:all
```

### SBT

```sourcegraph
"org.apache.logging.log4j" % "2.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))
file:\.sbt$ patterntype:regexp count:all
```

## Summary

Shown how we can easily find code. Covered the following:

* Multiple search mechanisms
* How we can refine the scope of our search
* And finally how we can filter the results

Objective is to say developers time - enabling them to focus on the job at hand.

# Understand Code

I can find relevant code and to look at the source code to gain a better understanding. I can use code intelligence - code navigation - to help understand how relevant symbols and classes are used in the rest of the codebase. 

I can also bring in other information to add context to the code for example 

* Who wrote it
* How has it changed
* How often
* Does it have good test coverage
* What is the code quality

```sourcegraph
new auth provider repo:^github\.com/sourcegraph/sourcegraph$ lang:Go type:symbol patterntype:regexp 
```

https://sourcegraph.com/github.com/sourcegraph/sourcegraph@5852bc09e9a5a04ed050a6583b7736140a9746d5/-/blob/enterprise/internal/authz/github/github.go?L155-175

# Visualise The Codebase

How can I track how the usage of a library, module or API is changing over time? Or if I am trying to migrate away from a library can I track progress? What versions of specific libraries are we using?

If I can easily visualise this information - essentially treat the codebase as a database - I can use this to help me make decisions regarding management of these initiatives.

Let me show you how we can visualise our code in Sourcegraph using code insights.

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ new auth provider type:symbol  patterntype:regexp lang:Go 
```

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) patterntype:regexp 
```

Example Dashboard

[Dashboard](https://demo.sourcegraph.com/insights/dashboards/ZGFzaGJvYXJkOnsiSWRUeXBlIjoiY3VzdG9tIiwiQXJnIjo3NDU5NH0=)

# Automate Changes

We have seen how we can use Sourcegraph to help easily find code, help teams collaborate through notebooks and then visualise our code - but obviously we need to change update our code at some point. What if we could automate some of the more straightforward change we need to make across our codebase? This would save time in terms of managing a process involving multiple people, reduce errors and let everyone focus on higher value work.

So for example lets assume I need to change an API or endpoint or update a library version how can Sourcegraph help us automate this process. 

We do this using what we call Batch Changes. Let us take a look at a Batch Change for our Log4j issue.

[Log4j Batch Change](https://demo.sourcegraph.com/users/dan.diemer/batch-changes/upgrade-log4j-2.17-gradle?tab=spec)

* Outline the three components of a batch change
* View changesets
* Show how we can track progress of MR/PR

Now in this example we have a small number of changesets but let us take a look at much larger example.

[Malo Medium Tracking](https://demo.sourcegraph.com/users/malo/batch-changes/medium-trackin-campaign)

And an example based on our NewAuhProvider method

[NewAuthzProvider](https://demo.sourcegraph.com/users/christine/batch-changes/Rename-newAuthzProvider/executions?visible=1)

## Investigate Error Message

New team members are often assigned a few tickets as part of their onboarding, to help them learn the codebase.

Let us see how Sourcegraph can accelerate this task by helping us search both the default branch but also search differences between branches and revisions.

Let us say I’m investigating an error message 

`ERROR: master id empty`

and you need to find the root cause. Let us first run a regular expression search where we try and find where this message may have been generated.

```sourcegraph
repo:^github\.com/sourcegraph/ (\s+|"|')id\s*empty patterntype:regexp 
```

We get a number of results returned.

In this instance we are seaching the default branch. We can take a look at the repo page. Here we can take a look at the files and symbols within the repo. We can examine specific branches or tags. And we can compare the differences between specific branches. So if we have an error than occurs in a specific revision we can start to examine the differences between these revisions.

We can of course take a look at the source code. And we can also look at the history of this file. 

And we can also search the commit messages and code diffs.

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ type:commit CreatePullRequest
```


So without pulling anything down locally, I can search the code, but also see how code has changed by comparing different revisions, and also search these changes.
