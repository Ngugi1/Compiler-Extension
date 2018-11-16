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

{ #category : #options }
AssertTest class >> debugMode [ 
	^ (1 = 2).
]

{ #category : #tests }
AssertTest >> test [
	^ self _assert: [ 1 = 1 ]
]
