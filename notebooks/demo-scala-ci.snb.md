# Scala

We provide three ways to search your code in Sourcegraph

* literal
* regexp
* structural

Structural search makes it much easier to search within blocks of code as they will in general be across multiple lines. Structural search is aware of the syntax of the language. So thats useful in a number of use cases. For example if we are trying to detect bad code patterns in our code we can use structural search to find them. Here are a couple of examples in Scala.

```sourcegraph
lang:Scala if (...) { } repo:scala count:1000 patterntype:structural
```


```sourcegraph
lang:Scala match { ... case ... match {...} } count:1000 patterntype:structural
```



# CI Pipeline


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
