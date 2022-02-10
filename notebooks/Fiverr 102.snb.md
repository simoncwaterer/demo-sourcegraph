# Agenda

* Notebook
* Type and Select
	* Searching Symbols
	* Searching for Diffs
* Search Contexts
* Structural Search
* Code Intelligence
* Use Case Survey

## Notebooks

Combine live code search, source code, markdown text and graphics in single document. Goal to enable developers and engineers to collaborate more effectively. Currently still in beta but available in Sourcegraph 3.36. First version will be released this quarter. 


* Reduce need for context switching	
* Creates a shareable trail of your exploration

### Examples

[Actor Propagation](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6OTI=)

[Find Log4j dependencies](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6MQ==)

### Future Plans 

* Granular permissions
* Import and export from/to third parties
* Embed Code Insights charts
* Create Batch Changes

## Type And Select Filter

[Type and Select](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6MTA1)

### Searching for Symbols


```Sourcegraph
context:global repo:^github\.com/apache/nifi.* jdbc -file:test
```

```Sourcegraph
context:global repo:^github\.com/apache/nifi.* jdbc -file:test type:symbol
```

```Sourcegraph
context:global repo:^github\.com/apache/nifi.* jdbc -file:test type:symbol select:symbol.class
```

### Searching for Commits and Code Diffs

[Search and Review commits / code Diffs](https://sourcegraph.com/notebooks/Tm90ZWJvb2s6MTI=)


## Search Contexts

Search Context added as part of Sourcegraph 3.33 release. Available to all and not just site admins. Replace version contexts and repogroups.

For teams, creating search contexts makes it easier to focus your searches on repos you care about. Let’s say, for example, that you work on internal tools and have a set of repositories you primarily work in. By creating a search context with those repos, you can have your searches scoped to the repos relevant to your work, ensuring the most relevant search results.

[Search Context Blog](https://about.sourcegraph.com/blog/introducing-search-contexts/)

Coming update will enable search context to be created directly from repo search query.


## Structural Search

Structural code search is the idea that you can search for syntactic structures in code that correspond more closely to a program’s underlying concrete syntax tree (or parse tree). What the hell is that !! So expressions and function blocks. It is is language-aware and understands basic syntax of code, strings, and comment syntax in many languages.

So code constructs such as (...), {...} and [...] as well as string literals and comments.


[Structural search blog](https://about.sourcegraph.com/blog/going-beyond-regular-expressions-with-structural-code-search/)

[Comby](https://comby.dev/)

Helps you search many kinds of code structures with greater ease than what regular expessions alone allow.

Lets see some examples

```sourcegraph
repo:^github\.com/sourcegraph/sourcegraph$ fmt.Sprintf(...) patterntype:structural
```

```sourcegraph
fprintf(stderr, ...) lang:c repo:^github\.com/torvalds/linux$ patterntype:structural
```

```sourcegraph
fprintf(stderr, ..., err) lang:c repo:^github\.com/torvalds/linux$ patterntype:structural 
```

```sourcegraph
if (!parts.length && ...) { ... } lang:javascript repo:^github\.com/google/.* count:all patterntype:structural
```

```sourcegraph
try {...} catch (...) { } finally {...} lang:java patterntype:structural
```

## Code Intelligence

Precise code intelligence relies on LSIF (Language Server Index Format) data to deliver precomputed code intelligence. It provides fast and highly accurate code intelligence but needs to be periodically generated and uploaded to your Sourcegraph instance. Precise code intelligence is an opt-in feature: repositories for which you have not uploaded LSIF data will continue to use the search-based code intelligence.

[LSIF Blog](https://about.sourcegraph.com/blog/evolution-of-the-precise-code-intel-backend/)

[LSIF Indexers](https://lsif.dev/)

[LSIF - Java, Scala, Kotlin](https://sourcegraph.github.io/lsif-java/docs/getting-started.html)

```sourcegraph
repo:^github\.com/Netflix/Hystrix$ file:^hystrix-core/src/main/java/com/netflix/hystrix/HystrixRequestCache\.java
```

## Use Case Survey

* Developer Onboarding
* Code Reuse
* Code Health
* Incident Response
* Fixing Vulnerabilities
