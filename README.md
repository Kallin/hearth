Hearth4J
========

_The Hearth4J project has the following goals:_

* **Document all past and present Hearthstone cards using Lua.**

    Why Lua? Lua is a long-lived scripting language that can be embedded in virtually any popular language from C to Java to Ruby.
    Documenting the cards in Lua should help to encourage adoption for use in other projects, and hopefully encourage others to offer pull requests to keep the database up to date.

    Currently the cards live in the [resources folder](https://github.com/Kallin/hearth/tree/master/src/main/resources/org/hearth4j/lua), though it may make sense to break them into their own separate github project.

* **Provide thorough testing of the card database.**

    Hearth4J offers thorough testing of the card database via [Spock tests](https://github.com/Kallin/hearth/tree/master/src/test/groovy).
    All the tests and code quality checks can be run by anyone with no environment setup thanks to the use of [Gradle](http://www.gradle.org/) as the build tool.

    Simply run *__gradlew check__* after cloning to execute the test suite locally.

* **Provide a reference Hearthstone engine in Java**

    Hearth4J will provide an engine to illustrate how to bind to the Lua cards, and what methods need to be implemented to operate with them.
    The engine will also allow tests to be written which verify that the logic of the cards is accurate in all scenarios.

* **But wait, there's more!**

    * offer a Web API into the card database, perhaps using another project which embeds Hearth4J
    * build configurable AIs that allow a player to practice against different strategies and different decks

Help us make it better
----------------------
Please tell us how we can make this project better. If you have a specific feature request or if you found a bug, please open a Github issue. Also, feel free to fork these docs and send a pull request with improvements!