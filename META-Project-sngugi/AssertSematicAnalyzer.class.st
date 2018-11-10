Class {
	#name : #AssertSematicAnalyzer,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visiting }
AssertSematicAnalyzer >> visitMessageNode: aMessage [
	| amessage |
	"Print Arguments"
	amessage := aMessage.
	aMessage arguments traceCr.
	aMessage selector = '_assert:'
		ifTrue: [ "We know we have an _assert"
			'We caught the assert' traceCr.
			"We know that we want a block, else we don't know how to evaluate this"
			amessage arguments first isBlock
				ifTrue: [ 'We have a block' traceCr.
					"amessage := self createAssertMessage: aMessage."
					amessage traceCr ]
				ifFalse: [ self error: '_assert takes a block as arguments!' ] ].
		^ super visitMessageNode: amessage.
]
