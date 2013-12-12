package org.hearth4j

import org.hearth4j.guice.HearthModule
import spock.guice.UseModules
import spock.lang.Shared
import spock.lang.Specification

import javax.inject.Inject

@UseModules(HearthModule)
class LibraryBasedTest extends Specification {

    @Inject
    @Shared
    private CardLibraryFactory cardLibraryFactory

    @Shared
    CardLibrary cardLibrary

    def setupSpec() {
        cardLibrary = cardLibraryFactory.make(new Version(Version.V1))
    }
}
