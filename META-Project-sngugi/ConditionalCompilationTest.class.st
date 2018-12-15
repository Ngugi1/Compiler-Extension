Class {
	#name : #ConditionalCompilationTest,
	#superclass : #Object,
	#category : #'META-Project-sngugi'
}

{ #category : #compiler }
ConditionalCompilationTest class >> compiler [
|compiler|
	compiler := super compiler.
	compiler compilationContext semanticAnalyzerClass: ConditionalCompilationSemanticAnalyser.
	^ compiler 
]

{ #category : #tests }
ConditionalCompilationTest >> test [
[1 = 1 ] _ifTrue: [  'okay' traceCr. 
	'hello' traceCr ] ifFalse: ['We are false' traceCr.
	'We are here again' traceCr]
]
