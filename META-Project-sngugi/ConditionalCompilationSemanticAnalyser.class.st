Class {
	#name : #ConditionalCompilationSemanticAnalyser,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #visiting }
ConditionalCompilationSemanticAnalyser >> visitMessageNode: aMessage [
| bloc |
	aMessage receiver isBlock 
	ifTrue: [ 
		"We have a block"
		bloc := aMessage receiver.
		'Before eval' traceCr.
		(bloc evaluate value) traceCr.
		'After eval' traceCr.
		bloc temporaryNames traceCr.
		"try to evaluate the block"
		(bloc evaluate) on: Error do: [ CannotResolveAtCompileTime signal ]. 
		"We know we have a block we can resolve at compile time"
		((bloc evaluate value class = True ) or: 
		(bloc evaluate  value class = False)) "Does the block evaluate to a boolean type?"
		ifTrue: [ "Evaulates to a boolean value"
			((aMessage selector = '_ifTrue:ifFalse:') or: (aMessage selector = '_ifTrue:')) "Is the selector of this form?"
			ifTrue: [ 
				"What is the value of the block"
			(bloc evaluate value) ifTrue: [ 
				"Inject code in the consequent block"
				(aMessage children at: 2) body  traceCr.
				aMessage parent replaceNode: aMessage  withNode: (aMessage children at: 2) body. 
				 ]
			ifFalse: [
				"Insert code at the alternative block"
				(aMessage children last) body traceCr.
				(aMessage selector = '_ifTrue:') ifTrue:  [ aMessage parent removeNode: aMessage ]
				ifFalse: [ aMessage parent replaceNode: aMessage  withNode: (aMessage children last) body. ]
				  ].
				 ].
			(aMessage selector = '_ifFalse:') ifTrue: [ 
				(bloc evaluate value) ifTrue: [ 
					aMessage children traceCr.
					aMessage parent removeNode: aMessage.
					 ]
				ifFalse: [ aMessage parent replaceNode: aMessage  withNode: (aMessage children last) body ]
				 ] 
			]
		
		
		ifFalse: [ "No it doesn't, throw exception"
			CompileTimeConditionMustBeBoolean signal.
			]
		 ].
	super visitMessageNode: aMessage.
]
