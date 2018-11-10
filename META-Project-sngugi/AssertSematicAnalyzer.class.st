Class {
	#name : #AssertSematicAnalyzer,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visiting }
AssertSematicAnalyzer >> visitMessageNode: aMessage [
	|selector|
	super visitMessageNode: aMessage.
	selector := aMessage selector.
	selector = '_assert:' 
	ifTrue: [ 'We caught the assert' traceCr ]
	ifFalse: [ 'No asserts caught' traceCr ]
	
]
