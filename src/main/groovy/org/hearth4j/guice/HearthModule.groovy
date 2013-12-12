package org.hearth4j.guice

import com.google.inject.AbstractModule
import com.google.inject.assistedinject.FactoryModuleBuilder
import org.hearth4j.CardLibraryFactory
import org.hearth4j.CardLoader
import org.hearth4j.lua.LuaClasspathCardLoader

class HearthModule extends AbstractModule {

    @Override
    protected void configure() {

        bind(CardLoader).to(LuaClasspathCardLoader)

        install(new FactoryModuleBuilder().build(CardLibraryFactory))

    }
}
