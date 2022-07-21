# Incident Response Demo

## Challenge of Managing Incidents

Responding and handling incidents is a fact of life for any development or engineering organisation.

And of course we want to be able to respond to any incident as efficiently as possible.

* minimize impact to clients and customers
* mitigate any vulnerabilities
* and also limit the impact on planned development schedule

But thats is challenging as a codebase gets more complex. It is hard to find and understand relevant parts of the code. 


## Sourcegraph and Incidents

* Today we will demonstrate how Sourcegraph improves incident response by 
helping you quickly search all your codebase to identify the root cause of an incident.
* And once identified, fix it everywhere so we don’t face the same issue again
* Finally create a markdown document that provides guidance on how to insure this bug does not reoccur.

## Find Root Cause

Let us assume we have a stacktrace that we are using to help find the root cause of a problem within our application. We will show how we can search our codebase to find the relevant code. We will then navigate the code so that we understand it better. Find who we should contact to help us. And finally open the code within our IDE.

The stack trace pointed to a null pointer error at *ExternalServiceWebhookMigrator*

So lets search our codebase to find the relevant code.

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ ExternalServiceWebhookMigrator
```

https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/cmd/worker/internal/migrations/migrators/extsvc_webhook_migrator.go?L55-65

This is a background process that is triggered by an update on the code host that causes an error when updating the database.

I can use Sourcegraph code intelligence to help me find references in other parts of the codebase - across other repos as well.

I can also look at the history of this file to see what has changed - perhaps some recent changes are relevant to the problem.

And I can add gitblame information to see who to contact. And I could generate a link to share to make sure we are looking at the same version of the code. And If I needed to make some changes I could open the code directly within my IDE.

Let’s assume I discuss with Eric. He says that the error check for the Transact function comes before the defer is causing a nil pointer issue on error

So we were able to:
* Quickly track down the code responsible for the run-time issue
* Gain an understanding of the code’s functionality using Sourcegraph's Code Intelligence
* And reach out to the relevant engineer with a quick link and a specific question

So now we are well on our way to resolving the problem.

Do devs themselves get on-call pages, or is there a separate SRE or ops team that is the front line?

What was the last incident your team faced? How long did that take to resolve and who got pulled in?

## Fix Issue

So from speaking to Eric I know the root cause. But what if this issue is elsewhere in the codebase? 

I can use Sourcegraph to determine where else this function is used and make sure that it is being used correctly.

Lets go back to our orginal source code. So we know from Eric that the way in which *Transact* is being called is not correct. I can take a look at this function - find out where else it is used and go to the definition - all using Code Intelligence.

https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/cmd/worker/internal/migrations/migrators/extsvc_webhook_migrator.go?L55-65

There are many instances of *Transact*, which means a lot of places where the same runtime panic could happen again if they’re not properly constructed.

There are two options, I can go through each individual file and review usage - or I could create a Batch Change to notify the team to please review how they are using Transact in the code.

*talk through batch change*

[Transact Batch Change](https://demo.sourcegraph.com/users/christine/batch-changes/transact-review?visible=5)

We have seen in this case a batch change can be used to trigger a review across relevant parts of the codebase for a potential problem. And of course could be used to change code in multiple repos.

How do you currently fix all occurences of a problem?

Now that we’ve resolved an incident, it would be useful to document correct usage of this particular function, so that we do not introduce this problem again.

We can use a Sourcegraph Notebook to document best practice. A notebook combines markdown text, live code search and code snippets into a single document. That means that the code samples we use are always uptodate.

[Transact notebook](https://demo.sourcegraph.com/notebooks/Tm90ZWJvb2s6Mw==)

This Notebook links to the other invocations and describes how to correctly use Transact, and the potential impact of misuse
I can also link to diffs where the issue was corrected

So in this case we have created a notebook that outlines correct use of a specific function. And of course we can use notebooks to document more complex troublshooting.

How do you currently share best practice across the team?

## Summary

I would love to get your feedback regarding what we have just seen.

* using Sourcegraph search and code intelligence to quickly find relevant code and gain a better understanding of that code.
* automate fixes across all code using Batch Changes 
* using notebooks to document and share best practice across the organisation

Do you have goals with respect to time-to-resolution?

What are all the tools that people need to consult when managing an incident?

What's painful about this today, and how would you like to improve the process?
