Class {
	#name : #AssertTest,
	#superclass : #Object,
	#instVars : [
		'debug'
	],
	#category : #'META-Project-sngugi'
}

{ #category : #compiler }
AssertTest class >> compiler [
	|compiler|
	compiler := super compiler.
	compiler compilationContext semanticAnalyzerClass: AssertSematicAnalyzer.
	^ compiler.
]

{ #category : #'as yet unclassified' }
AssertTest class >> debugMode [
	^(1 = 1)
]

{ #category : #tests }
AssertTest >> test [
	^self _assert: [ 2 = 3].
]
