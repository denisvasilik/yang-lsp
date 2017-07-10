/*
 * Copyright (C) 2017 TypeFox and others.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 */
package io.typefox.yang.diagram

import com.google.inject.Singleton
import io.typefox.sprotty.api.IDiagramServer
import io.typefox.sprotty.api.LayoutUtil
import io.typefox.sprotty.api.SModelRoot
import io.typefox.sprotty.server.xtext.DiagramLanguageServerExtension
import io.typefox.sprotty.server.xtext.LanguageAwareDiagramServer
import java.util.List

@Singleton
class YangLanguageServerExtension extends DiagramLanguageServerExtension {
	
	override protected initializeDiagramServer(IDiagramServer server) {
		super.initializeDiagramServer(server)
		val languageAware = server as LanguageAwareDiagramServer
		languageAware.needsServerLayout = true
	}

	override protected updateDiagrams(List<SModelRoot> newRoots, String uri) {
		if (!newRoots.empty) {
			val server = findDiagramServerByUri(uri)
			val newRoot = newRoots.head
			LayoutUtil.copyLayoutData(server.model, newRoot)
			server.updateModel(newRoot)
		}
	}

}