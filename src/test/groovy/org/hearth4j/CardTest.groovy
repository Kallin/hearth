package org.hearth4j

import groovy.util.logging.Slf4j
import spock.lang.Ignore

@Slf4j

class CardTest extends LibraryBasedTest {

    @Ignore
    def 'all cards can be cast'() {

        expect:
        cardLibrary.allCards.each { card ->
            if (card.type == 'card' && !card.broken) {
                log.trace "casting $card"
                card.onCast.invoke()
            }

        }

    }


}
