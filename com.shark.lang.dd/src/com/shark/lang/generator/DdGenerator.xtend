/*
 * generated by Xtext 2.21.0
 */
package com.shark.lang.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DdGenerator extends AbstractGenerator {

	val myFlatDdGenerator = new FlatDdGenerator

	//using several generators might have a perf option vs. spitting out several files
	//but if they are optional (like different styles SQL output or not... ) then
	//better to separate. In the case of the sample data app it should be outside of the raw flatbuffer
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		myFlatDdGenerator.doGenerate(resource, fsa, context)
	}

}
