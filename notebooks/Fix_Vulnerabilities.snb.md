# Fix Vulnerabilities Demo

Almost 22,000 vulnerabilities were published in 2021.  The mean time to remediation for high risk vulnerabilities is 84 days.

Take for example a recent vulnerability: log4j. An issue that was discovered late 2021. Attackers could load code to attack effected applications. 

We very quickly released a blog outlining how Sourcegraph could be used to address this issue.

Today, I’m going to show you how Sourcegraph can help you quickly and accurately find vulnerabilities, fix them automatically, monitor progress of fixes and ensure that we can stop these vulnerabilites being reintroduced. And I will use the log4j as an example.


In the next few minutes I will demonstrate the following:

* how we can find code affected by the log4j issue
* how we visualize the vulnerabilities across the codebase over time
* how we automate changes to our code to fix the vulnerability
* and finally how we can generate alerts if an effected log4j version is reintroduced.

## Find Effected Code

Let us start with finding effected code within our codebase. We will see how easy it is to search the codebase, share results and also create a notebook to document our investigation.

Let us start with running the following regex search on the codebase.

In this particular case we are looking for at risk log4j versions with gradle files.

Here we can see a number of results very quickly from multiple code hosts and multiple repositories

I could share the search query. I could save the search query. I could export the results to a CSV file and use this to assign tasks to relevant development teams.

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) patterntype:regexp 
```

Or we could use what we call a notebook to share our investigation with team members. A notebook combines code search, code snippets and markdown text into a single document. Here is one we created for log4j.

[Log4j Notebook](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6MQ==)

We have seen how Sourcegraph can help us quickly discover where the risks are within the codebase.

How would you go about this today?

## Visualize Code at Risk

We have found the code at risk. And the intent is to fix the problem. In this instance we want to replace vulnerable versions of log4j with patched versions. What if I could visualize how how the codebase is changing over time with respect to a particular security issue we are working on?

We do this in Sourcegraph using what we call code insights.

Let us start by running the previous search. We can see that I can create a code insight directly from the search results.

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) patterntype:regexp 
```

```sourcegraph
org.apache.logging.log4j['"] 2.(17)(.[0-9]+) patterntype:regexp
```

I could run this over all repos but for the demo let me select a few sample repos. I could use the CSV export feature or API to give me a list of all repos that I know currently are at risk. And in the interests of time lets me select an insight I have created already.

github.com/dhdiemer/sample-vulnerable-log4j-direct-lib,
github.com/dhdiemer/udpated-vulnerable-log4j-direct-lib,
github.com/dhdiemer/updated-vulnerable-log4j-direct-app,
github.com/sgtest/sample-vulnerable-log4j-direct-app,
github.com/sgtest/sample-vulnerable-log4j-direct-lib,
gitlab.com/dhdiemer/sample-vulnerable-log4j-direct-lib,
gitlab.com/dhdiemer/updated-vulnerable-log4j-direct-app,
gitlab.com/dhdiemer/udpated-vulnerable-log4j-direct-lib,
github.com/dhdiemer/sample-vulnerable-log4j-indirect-app,
gitlab.com/dhdiemer/sample-vulnerable-log4j-indirect-app,
github.com/dhdiemer/updated-vulnerable-log4j-indirect-app

[Log4j Migration Insight](https://demo.sourcegraph.com/insights/edit/aW5zaWdodF92aWV3OiIyNU9URmRkSHp4MnRkZnRhdGpMbmExZ2I0Y0gi?dashboardId=all)

We have limited the repos we are using. And we have added a second chart to see how many of the vulnerabilities have been fixed. I could then save this insight. Add it to an existing dashboard or create a new one.


We have seen how with Code insights I can visualize how my code base is changing over time. This provides great feedback to me in terms of managing progress with respect to my key initiatives.

What type of dashboards do you currently make use of?

## Automate Code Changes  

We want to update our code to remove the log4j vulnerability, we need to update the log4j versions we are using across all our repos.

Let us see how Sourcegraph can enable us to automate these changes. Allowing our developers and engineers to focus on higher value work. We do this in Sourcegraph using the batch change capability. Here is one we have created for the Log4j issue.

[Log4j Batch Change](https://demo.sourcegraph.com/users/dan.diemer/batch-changes/upgrade-log4j-2.17-gradle?tab=spec)

* Outline the three components of a batch change
* View changesets
* Show how we can track progress of MR/PR

Now in this example we have a small number of changesets - we are not that impacted by log4j - but lets take a look at much larger example.

[Malo Medium Tracking](https://demo.sourcegraph.com/users/malo/batch-changes/medium-trackin-campaign)

* Show Burndown chart

Sourcegraph batch changes lets you fix vulnerabilities at scale. This reduces errors, development effort and allows us to focus on higher value work.

How does your organization make widespread fixes like this today? And how do you manage the process?

## Monitor Codebase  

Once we have made our fixes we want to make sure that they don't come back. Let us create a code monitor that will alert us if a vulnerable log4j version is added.

If we run our search again - this type we will run a diff - we can see that we can create a code monitor from the search results.

A code monitor enables us to create an alert if code is committed which triggers the search parameters. When the trigger is fired we can figure an alert via email, webhook or slack.

```sourcegraph
lang:gradle org\.apache\.logging\.log4j['"] 2\.(0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16)(\.[0-9]+) repo:dhdiemer type:diff
```

## Summary

In summary we have seen

* how we can easly find code impacted by a vulnerability
* create time based charts to enable us to visualize progress
* automate changes to the code to fix the issue
* and generate alerts to warn us if the issue is reintroduced 

We have used Log4j as an example. But the above can be applied to a range of security issues.

Love to get your feedback on what we have seen. But also get a better understanding of how you currently address similar issues?
