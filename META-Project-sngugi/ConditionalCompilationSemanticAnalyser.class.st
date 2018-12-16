Class {
	#name : #ConditionalCompilationSemanticAnalyser,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'META-Project-sngugi'
}

{ #category : #'as yet unclassified' }
ConditionalCompilationSemanticAnalyser >> evaluatesToBoolean: bloc [
	^ ((bloc evaluate value class = True ) or: 
		(bloc evaluate  value class = False))
	
]

{ #category : #visiting }
ConditionalCompilationSemanticAnalyser >> visitMessageNode: aMessage [
| block |
	aMessage receiver isBlock 
	ifTrue: [ 
		"We have a block"
		block := aMessage receiver.
		"try to evaluate the block"
		(block evaluate) on: Error do: [ CannotResolveAtCompileTime signal ]. 
		"We know we have a block we can resolve at compile time"
		(self evaluatesToBoolean: block) "Does the block evaluate to a boolean type?"
		ifTrue: [ "Evaulates to a boolean value"
			(aMessage selector = '_ifTrue:ifFalse:' or: aMessage selector = '_ifTrue:')
			"Is the selector of this form?"
			ifTrue: [ 
				"What is the value of the block"
			(block evaluate value) ifTrue: [ 
				"Inject code in the consequent block"
				(aMessage arguments first) body  traceCr.
				aMessage parent replaceNode: aMessage  withNode: (aMessage arguments first) body. 
				 ]
			ifFalse: [
				"Insert code at the alternative block"
				(aMessage children last) body traceCr.
				(aMessage selector = '_ifTrue:') ifTrue:  [ aMessage parent removeNode: aMessage ]
				ifFalse: [ aMessage parent replaceNode: aMessage  withNode: (aMessage arguments last) body. ]
				  ].
				 ].
			(aMessage selector = '_ifFalse:') ifTrue: [ 
				(block evaluate value) ifTrue: [ 
					aMessage parent removeNode: aMessage.
					 ]
				ifFalse: [ aMessage parent replaceNode: aMessage  withNode: (aMessage arguments last) body ]
				 ] 
			]
		
		
		ifFalse: [ "No it doesn't, throw exception"
			CompileTimeConditionMustBeBoolean signal.
			]
		 ].
	super visitMessageNode: aMessage.
]
