Class {
	#name : #AssertTest,
	#superclass : #Object,
	#category : #'META-Project-sngugi'
}

{ #category : #compiler }
AssertTest class >> compiler [
	|compiler|
	compiler := super compiler.
	compiler compilationContext semanticAnalyzerClass: AssertSematicAnalyzer.
	^ compiler.
]

{ #category : #tests }
AssertTest >> test [
	^ self _assert: [ 1 = 1 ]
]
