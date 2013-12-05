package org.hearth4j

import org.hearth4j.lua.LuaClasspathCardProvider
import spock.lang.Shared
import spock.lang.Specification

abstract class LibraryBasedTest extends Specification{

    @Shared CardLibrary cardLibrary;

    def setupSpec() {
        final provider = new LuaClasspathCardProvider()
        cardLibrary = provider.provideCards(new Version(Version.V1))
    }


}
