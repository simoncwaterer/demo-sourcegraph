# Log4j

Improving code security is a problem that SAP have been investing in for over 20 years. SAP have shifted their development from in house software to a greater reliance on open-source libraries and components. This results in greater productivity but comes with the challenge of how to securely integrate these libraries and components.

Last year almost 22,000 vulnerabilities were published.  The mean time to remediation for high risk vulnerabilities was 84 days. Take for example a recent vulnerability: log4j. An issue that was discovered late 2021. Attackers could load code to attack effected applications. 

We very quickly released a [blog](https://about.sourcegraph.com/blog/log4j-log4shell-0-day) outlining how Sourcegraph could be used to address this issue.

This notebook will show how Sourcegraph can help you quickly and accurately find this vulnerability, automate fixes and track progress progress of fixes. A notebook is designed to enable developers and engineers to collaborate when investigating an issue by sharing context, code search and code snippets.

Run these queries on Sourcegraph to quickly determine which projects directly depend on vulnerable versions of log4j. The following search queries identify vulnerable dependencies on Sourcegraph Cloud across 2M public repositories.

## Gradle

```sourcegraph
org\.apache\.logging\.log4j' 2\.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))
lang:gradle patterntype:regexp count:all
```

## Maven

```sourcegraph
<log4j\.version>2\.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))</log4j\.version>
file:pom\.xml patterntype:regexp count:all
```

## SBT

```sourcegraph
"org.apache.logging.log4j" % "2.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))
file:\.sbt$ patterntype:regexp count:all
```

## Any file containing org.apache.logging.log4j followed by a vulnerable version number

```sourcegraph
org\.apache\.logging\.log4j 2.((0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)(\.[0-9]+))
patterntype:regexp count:all
```

https://sourcegraph.com/github.com/SonarSource/sonarqube@601e7fbb0ca7cd323b69742e15cd016dac46cf62/-/blob/build.gradle?L367

### Example: a list of files to update

https://sourcegraph.com/github.com/projectlombok/lombok@37d548c7fa1db5284227a861089857fc20de06ce/-/blob/buildScripts/ivy.xml?L48

https://sourcegraph.com/github.com/lagom/lagom@12e8ee61f0f4c3a3658fd569b5562c0de2b292c5/-/blob/docs/manual/java/guide/logging/code/build-log-lang.sbt?L27

## Visualise the Codebase

We have found the code at risk. And we can begin to remediate the issue. We can also visualize the progress we are making with respect to fixing the problem.

We do this in Sourcegraph using what we call code insights. The following is the output from a code insight.

![the dog](https://storage.googleapis.com/sourcegraph-assets/blog/log4j/log4j-code-insights.png)

## Automate Code Changes  

In this case we need to update the log4j version being used. Sourcegraph can enable us to automate these changes. Allowing our developers and engineers to focus on higher value work. We do this in Sourcegraph using what we call batch changes. Below is a screenshot of a batch change spec.

![Batch Change Script](https://storage.googleapis.com/sourcegraph-assets/blog/log4j/log4j-track-progress-prs.png)
