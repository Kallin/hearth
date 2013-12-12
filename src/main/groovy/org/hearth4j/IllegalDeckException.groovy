package org.hearth4j

import groovy.util.logging.Slf4j

@Slf4j
class IllegalDeckException extends Exception {

    IllegalDeckCause illegalDeckCause

    IllegalDeckException(IllegalDeckCause illegalDeckCause, List<Card> cards) {
        super("illegal deck due to [$illegalDeckCause]")
        this.illegalDeckCause = illegalDeckCause
        log.error(cards.toString())
    }
}

enum IllegalDeckCause {
    TOO_BIG,                // a deck must consist of 30 cards
    TOO_SMALL,
    TOO_MANY_LEGENDARIES,   // a deck can only contain one of each legendary
    TOO_MANY_OF_TYPE,       // a deck can only contain 2 of any card
    WRONG_HERO              // a deck can only contain cards belonging that are neutral or belonging to it's hero
}
