## SAP Security Coding Best Practice

Hi Praveen I'm Simon Waterer. I'm a customer engineer at Sourcegraph. I took a look at the the questions you sent us. 

I certainly think that Sourcegraph could potentially be of value. Now I am not an SME with respect to topics you outlined in your email. However, I would suggest that the SAP Business Technology Platform codebase - that includes application and platform code, infrastructure as code and definitions of CI/CD pipelines - contains the answers to these questions. So for example a build and deployment pipelines will likely indicate if source code is properly signed and verfied. The challenge of course is finding and discovering this information if you are not farmiliar with that part of the codebase.

And really this is where Sourcegraph comes - providing developers and architects a universal search platform across the entire codebase for a platform.

So what I would like to do is to cover a few examples which I hope will stimulate some more detailed discussions.

I will show you some examples of code search and code navigation, how we can visualise how our codebase changes over time and finally touch on how we can automate changes to the code.

Right lets dive in.....



So we have covered.....

One final point. 

Obviously there are a range of great tools out there that can scan code for vulnerabilites or code quality. 

Sourcegraph is a general purpose platform - but the advantage of that is that as you need to answer a different set of questions - you don't need us to update the platform to enable you to find the answers.

I hope this has been useful and obviously more than happy to discuss further. Thank you.



*Search
*Insights
*BC - just mention as they are not developers/engineers so not responsible for changes.

which examples have a batch change -

Log4j
Docker Components

Log4j
Migration of React function components
Unpinned docker components
Linter checkov 
CI Tooling

* is MFA based authN enabled everywhere?
* are relevant datasets encrypted in all services?
* are all services doing secret-less service-2-service exchanges?
* is source code used in supply chain protected and signature verified in deployments?
* can we leverage industry benchmarks against internal findings to reduce false positives?

You might also share our security templates (in-product on this page if you are ever looking for them, in docs here, screenshot attached). We also have a security related capture group example for catching the reasons for security linter overrides on this dashboard geared towards security engineers. Or you can share our entire templates page as well to see what that helps them discover.

https://demo.sourcegraph.com/insights/about?dashboardId=all
https://docs.sourcegraph.com/code_insights/references/common_use_cases#security
https://demo.sourcegraph.com/insights/dashboards/ZGFzaGJvYXJkOnsiSWRUeXBlIjoiY3VzdG9tIiwiQXJnIjo3NDU0Mn0=
https://docs.sourcegraph.com/code_insights/references/common_use_cases#common-code-insights-use-cases-and-recipes

```sourcegraph
mfa\_?token lang:JavaScript  patterntype:regexp 
```

```sourcegraph
file:^\.eslintignore .\n patternType:regexp archived:no fork:no
```

```sourcegraph
lang:Terraform archived:no fork:no #checkov:skip=(.*) 
```

```sourcegraph
file:\.circleci/config.yml select:repo fork:no archived:no patterntype:regexp 
```
