# Type and Select

Type and Select are just two of the filters available within Sourcegraph to enable users to refine the scope of a code search. They are often used together. And initially I found their use a little confusing. But I think of *Type* as narrow the scope of a search i.e. what we should search in and *Select* as returning a subset of the search results.

## Type

Types define the scope of code search. A search scope consists of commits, diffs, symbols, repos, paths and files. It is typically used alongside other search commands to further narrow search results.

## Select

Selects the specified result type from the set of search results. If a query produces results that aren’t of the selected type, the results will be converted to the selected type.

Lets take a look at some examples of using *type* and *select*.

The first three options to *type* are:

* path - search file path / name
* file - search file contents
* repo - search repository name

By default if a type: parameter is not specified then the search will effectively add type:repo, type:file and type:path.

The addition of the file filter disables type:repo results.

So the following will find matches in repo name, file paths and files contents.

```sourcegraph
repo:^github\.com/apache/.* kafka
```

This will only return repositories which match our query.

```sourcegraph
repo:^github\.com/apache/.* kafka type:repo
```

And the following query will only return results where the file contents match our query.

```sourcegraph
count:10  repo:^github\.com/apache/.* kafka type:file
```

## Finding Symbols

I can also use *type* to enable to find matches in symbols within our source code. So lets change our earlier query a little bit so that I only find symbols that match my query string.

```sourcegraph
repo:^github\.com/apache/kafka$ kafka producer type:symbol lang:Java patterntype:regexp 
```

And if I am only interested in symbols of a particular type I can use *select* to return only the relevant symbols, so in this case Java classes that match my query.

```sourcegraph
repo:^github\.com/apache/kafka$ kafka producer type:symbol select:symbol.class lang:Java  patterntype:regexp 
```

## Modified Lines

By default when we search in Sourcegraph we search against the default branch. We can use *type* to allow us to search against changes in the code or the commit messages. And when searching for code changes we can use *select* to include results depending whether code was added or removed.

```sourcegraph
repo:^github\.com/apache/kafka$ kafka producer type:commit after:"last month" patterntype:regexp 
```

```sourcegraph
repo:^github\.com/apache/kafka$ kafka producer type:diff select:commit.diff  after:"last month" patterntype:regexp 
```

dsdfsdf

```sourcegraph

```
