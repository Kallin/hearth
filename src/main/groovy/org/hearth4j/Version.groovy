package org.hearth4j

//todo: encapsulate expected card counts in here as much as possible
class Version {

    String version

    Version(String version) {
        if (!version in knownVersions)
            throw new IllegalArgumentException('unknown version')

        this.version = version
    }

    public final static String V1 = '1.0.0.3937'

    def knownVersions = [
            V1
    ]


}
