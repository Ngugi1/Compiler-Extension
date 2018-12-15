Class {
	#name : #AssertSematicAnalyzer,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visiting }
AssertSematicAnalyzer >> visitMessageNode: aMessage [
	| params |
	aMessage methodNode methodClass debugMode traceCr.
	"Print Arguments" 
		aMessage selector = '_assert:' 
		ifTrue: [ 
			"We know we have an _assert"
			"We know that we want a block, else we don't know how to evaluate this"
			aMessage arguments first isBlock
				ifTrue: [ 
					aMessage methodNode methodClass debugMode 
					"Dynamically remove assert: at compile time"
					ifTrue: [
						params := OrderedCollection new.
					params add: aMessage arguments first body statements first.
					aMessage parent replaceNode: aMessage  withNode: (RBMessageNode receiver:  aMessage receiver selector: 'assert:'  arguments: params).
						 ] 
					"Add an assert:aBooleanOrClosure with empty body"					
					ifFalse: [ aMessage methodNode methodClass compile: 'assert:aBooleanOrClosure' ].
					
					]
				ifFalse: [ self error: '_assert takes a block as arguments!']
				].
		^ super visitMessageNode: aMessage.
]
