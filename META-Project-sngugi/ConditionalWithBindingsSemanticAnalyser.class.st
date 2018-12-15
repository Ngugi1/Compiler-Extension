Class {
	#name : #ConditionalWithBindingsSemanticAnalyser,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visitor }
ConditionalWithBindingsSemanticAnalyser >> visitMethodNode: aMethodNode [
|keys dict|
	
	(aMethodNode hasPragmaNamed: 'constantDefinition') 
	ifTrue: [ 'Pragma detected' traceCr.
		dict := (aMethodNode methodClass perform: #addCompileTimeVariables).
		aMethodNode methodClass compiler  compilationContext  bindings: dict.
		keys := OpalCompiler new class: ConditionalWithBindings ; evaluate: 'Bits64'.
		keys traceCr. 
		keys := dict keys.]
		ifFalse: [ 'No Pragma' traceCr ].
super visitMethodNode: aMethodNode
]
