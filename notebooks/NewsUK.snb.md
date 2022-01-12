# NewsUK


[https://sourcegraph.com/search](https://sourcegraph.com/search)

So this is the browser based UI for sourcegraph. As you can see at first glance it is similar to Google or other search engines.


### Deployment

Now in this instance I am using a public SG instance at sourcegraph.com. Our clients either use a managed instance that we deploy and run for them, or run their own instance on public or private cloud infrastructure. From a deployment perspective we provide support for kubernetes and also docker compose. Looking below the search bar I can see a history of searches that I have run and repos that I have visited.

### Search Contexts

Looking at the search bar on the left I can see a drop down labelled context. A search context represents a set of repositories at specific revisions on a SG instance that will be targeted by the search queries I execute. So for example I could create a search context that targets my frontend code.


##Developer Onboarding / Code Reuse 

- creating new function
- reusing existing code
- understanding impact of code changes


### Literal Search

So if I wanted to find some scary code I might run the following search query -

“Here be dragons”

[https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal](https://sourcegraph.com/search?q=context:global+here+be+dragons&patternType=literal)

```sourcegraph
here be dragons patternType:literal
```

So in this instance we are using the default search mechanism provided by SG - literal search. SG provides three search mechanisms - literal search, regular expression search and structural search. Using literal string search is great if you have a good idea of the symbol name or phrase you need to look for. And literal search is probably what you are used to using.

####Incident Tracking
Let us take a look at another example. Let us assume that I have to do some troubleshooting. I have an error message that I am not familiar with. If I can search for the error message I can see where in the code the message was generated. And begin to determine the root cause. Here we have a log file - a Sourcegraph log file in fact - I can see the following error in this file. 

_performing background repo update_

```sourcegraph
performing background repo update patternType:literal
```

### Create New Function

Let us assume I’m a relatively new member of the team and I have been asked to add a new authentication provider. So I want to search the code base to see if I can find some examples and hopefully get a head start.

So let us use the term

“new auth provider”

And stick to using literal search in the first instance.

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=literal)

```sourcegraph
new auth provider patternType:literal
```

But what if we switched to a regular expression search instead?

[https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider&patternType=regexp)

```sourcegraph
new auth provider patternType:regexp
```

So now I am getting more results from the source code itself. But we are still searching across all repos, can we narrow it down a little? If we look at the left hand side of the search results we can see the  SG has kindly suggested a number of filters that we could use or dynamic filters as they are labelled here. One is I can filter by language. So I know that SG is largely written in GO so it makes sense to only select results from go files.


[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+&patternType=regexp)

```sourcegraph
new auth provider lang:go patternType:regexp
```

And we also might want to exclude certain files, test files for example, these probably are not going to help me.


[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+-file:_test%5C.go%24+&patternType=regexp)

```sourcegraph
new auth provider lang:go -file:_test\.go$ patternType:regexp
```

And of course I’m only really interested in sourcegraph codebase in this instance so I can add a filter so that we are only looking at certain repos.

[https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp](https://sourcegraph.com/search?q=context:global+new+auth+provider+lang:go+repo:%5Egithub%5C.com/sourcegraph/sourcegraph%24+-file:_test%5C.go%24+&patternType=regexp)

```sourcegraph
new auth provider lang:go -file:_test\.go$ repo:^github\.com/sourcegraph/.* patternType:regexp
```

So now we can see some files which I am confident are really going to be relevant to my task. I can see the number of matches in each file and the files are ordered by star ranking on github. So we have a few comments but if I scroll down I see a file with 11 matches. So this might be worth taking a closer look at. Let us select this file.

[https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go](https://sourcegraph.com/github.com/sourcegraph/sourcegraph/-/blob/enterprise/internal/authz/authz.go)

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ file:^enterprise/internal/authz/authz\.go
```

### IDE + Code Intelligence

So now we have a more IDE-like view. We have the file in the main pane. And on the left we have the files that are in the same directory in the repo and also symbols defined in this source code. In the main pane we provide code intelligence via a hover tooltip. We can see the function definition, comments and we can go to the definition and find references, and that is irrespective whether these are in this repo or a separate repo.


## Governance

- updating internal / third party components
- monitoring codebase
- tracking changes to the codebase
- automated updates

###CI Pipeline


If we are using a CI pipeline and we want to updated a particular docker image how can we determine the impact of the change? What repos and files are effected? Lets try and find the impacted files. Lets assume our CI pipeilines live in Yaml files and that they contains a ```image:``` key.

```sourcegraph
lang:Yaml image:
```

So if we look at our results we see quite a number of different CI pipelines in use. Obviously in reality this would probably not be the case. So lets narrow our search. In this case I am going to assume we are using the Cirrus CI pipeline.

```sourcegraph
file:circle.*\.yml lang:Yaml image: count:all
```

File and other filters use regular expressions by default. Lets update the pattern so that we are sure that we have found the relevant files.

```sourcegraph
file:circle.*\.yml -\simage: lang:Yaml count:all patternType:regexp
```
So we can see that we have a lot of results returned. Lets select one of the files and take a look at it. So in addition to enabling us to search the code we can add additional context information. So for source code this might include code coverage and code quality information from third parties such as code cov and sonarqube. For a configuation file we can add git blame information - help us understand who was responsible for changes etc.

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage: lang:Yaml repo:facebook patternType:regexp
```

But we can also search code diffs and commit messages and define time intervals to again help us understand the changes that have been made. Lets take a look at an example of that. Now when searching code diffs and commit messages we need to limit the scope of the search to less than 10K repos. There seem to be some facebook repos in our results so let narrow down our scope a little.

So lets see when we added or updated a docker image for python in the last year

```sourcegraph
file:circle.*\.yml lang:Yaml -\s+image:.*python repo:facebook type:diff select:commit.diff.added after:"1 year ago" patternType:regexp
```

But perhaps we are only interested in the repos or files rather than the matches. We can use this info as input to a report or project plan potentially. So lets only select the repos rather than the matches.

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage: repo:facebook select:repo patternType:regexp
```

We can also generate this data via our GraphQL API.

```
query ($query: String!) {
  search(query: $query, version: V2, patternType:regexp) {
    results {
      results {
        ... on Repository {
          ...RepositoryFields
        }
      }
    }
  }
}

fragment RepositoryFields on Repository {
  name
  url
}

{
    "query": "file:circle.*\\.yml lang:Yaml -\\simage: repo:facebook select:repo"
}
```

So we have managed to find the repos and files that we are interested in by being able to search across all of our repos. We can see the images used in all our CI pipeline. Lets assume that we are only interested in a particular image, the circle ci node image. This is referenced in a number of places. Lets update our search expression.

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node patterntype:regexp
```

We have a number of different versions in use. Now if I look at the documentation it appears that this image has now been replaced by another image - circleci/node:tag -> cimg/node:tag. Perhaps I want to know if anyone makes an update to a pipeline and adds the old image - it would be useful to be notified. With sourcegraph we can use search as a platform to enable us to monitor changes in the code base through code monitoring.

Now currently we can't monitor every repo - so we need to limit the number of repos. Lets take a look at the Unity-Technologies repos and base our monitor on that repo.

```sourcegraph
file:circle.*\.yml lang:Yaml -\simage:\s+circleci/node repo:^github\.com/Unity-Technologies/com\.unity\.cv\.datasetvisualizer$ type:diff patterntype:regexp
```

So we can search or query the code - the data - we can define monitor or triggers on the data. What if we could also get a picture over time of how our codebase is changing? For example how quickly are we migrating to and from a particular package or technology? Again we have used the sourcegraph search platform to enable us to visualise this information through what we call Code Insights. As of 2021 this is still a beta capability. 
