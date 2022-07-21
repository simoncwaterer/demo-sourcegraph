# Developer Onboarding Demo

## The Challenge of Onboarding

Everyone wants to onboard as efficiently as possible, whether you’re a new employee or a senior employee moving teams or projects.

Onboarding anyone into a new role or new team is hard. Everyone is excited a new engineer is joining. They get their laptop and settle in. And of course they are keen to deliver as soon as possible. 

How can we ensure that the onboarding process makes someone feel that they are making progress? 

And generally feeling good about themselves. And also that we are not slowing them down.

And of course everyone else stills needs to get on with the day job.

We’re going to see how Sourcegraph empowers engineers to solve more of their own problems and answer more of their own questions.

We will see how we can view and search all of our code, all branches and all commits. How we can combine documentation and live code search to provide information on best practice and standards.

## First Steps

Lets start with a simple search using Sourcegraph. Let us see how we can search straight from the address bar, bring up the source code we are interested in and then quickly see who contributed to the source code.

[about Sourcegraph](https://about.sourcegraph.com/)

Lets search for the following

1. *Move fast, even in big codebases.*
2. *Search using src in chrome header*
3. *Click into the sg/sg markdown file*
4. *Show GitBlame*
5. *Show branch dropdown*

## Understanding Best Practice

As a new developer, one of the hardest tasks is figuring out best practices at a new company.

1. What are the they?
2. Where are things located?
3. How are they organized?
4. What anti-patterns should I avoid?

If I have a good understanding of best practice it will help ensure that when I do start commiting code; code reviews will progress more smoothly.

One way we can help developers get up to speed with respect to best practice is with Sourcegraph Notebooks.

We will 

1. Outline the purpose of notebooks
2. Show an example notebook
3. Outline how you can create notebooks

So what is a Sourcegraph notebook? 

A Sourcegraph notebook combines markdown text, live code search and code snippets into a single living document. They are inspired by Jupyter notebooks which are commonly used within data science.

The objective is to help developers and engineers to share information about a codebase including best practice, development standards and programming patterns with the goal of improving code health and reducing technical debt. Notebooks also help new devs self-serve, freeing up your valuable resources.

Let us take a look at a notebook example.

The Sourcegraph platform is built using Go. Within the platform a framework of actors is used to help manage concurrency. This notebook outlines how context is propagated both within Sourcegraph services and between multiple services.

[Actor Propagation](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6OTI=)

*Run all blocks and scroll through search results and source code*

We will run all the search queries embedded within the notebook.

The first set of search results show how the actor framework is used within Sourcegraph services. So for example how the actor.withActor() method is used. I can scroll through the results.

*Scroll down to propagation between services*

Moving further down we can see that relevant source code for actor.HTTPTransport has also been embedded.

The goal here is to make it much easier for a new member of the team to get up to speed as quickly as possible.

We can create notebooks within Sourcegraph. And we can also import and export notebooks. And we provide a notepad feature to enable people to create a notebook during a code search session.

So we have seen that notebooks are designed to help teams collaborate and help new devs self-serve

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

Let us go back to our search results and take a look at one of the files returned.

We can of course take a look at the source code. And we can also look at the history of this file. 

Return to search results and open a file and view its history.

And we can also search the commit messages and code diffs.

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ type:commit CreatePullRequest
```


So without pulling anything down locally, I can search the code, but also see how code has changed by comparing different revisions, and also search these changes.

## Summary

We have seen how Sourcegraph empowers developers to answer more of their own questions.

1. Browser extension make it super easy to launch a search query straight from the address bar
2. Sourcegraph notebooks provides a rich document format for best practice and coding standards
3. We can view and search differences between multiple revisions and branches
4. View commit history for every file

All without having to clone any repos.

This enables individuals to get up to speed more quickly and allow their colleagues to stay in flow.

Do you have a process for onboarding new team members? What does the onboarding process consist of?
