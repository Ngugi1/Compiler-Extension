Class {
	#name : #AssertSematicAnalyzer,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visiting }
AssertSematicAnalyzer >> visitMessageNode: aMessage [
	| params |
	aMessage traceCr.
	"Print Arguments" 
		aMessage selector = '_assert:' 
		ifTrue: [ 
			"We know we have an _assert"
			"We know that we want a block, else we don't know how to evaluate this"
			aMessage arguments first isBlock
				ifTrue: [ 
					params := OrderedCollection new.
					params add: aMessage arguments first body statements first.
					aMessage parent replaceNode: aMessage  withNode: (RBMessageNode receiver:  aMessage receiver selector: 'assert:'  arguments: params).
					]
				ifFalse: [ self error: '_assert takes a block as arguments!']
				].
		^ super visitMessageNode: aMessage.
]
