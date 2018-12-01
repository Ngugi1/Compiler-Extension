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
		"try to evaluate the block"
		(bloc evaluate) on: Error do: [ CannotResolveAtCompileTime signal ]. 
		"We know we have a block we can resolve at compile time"
		((bloc evaluate value class = True ) or: 
		(bloc evaluate  value class = False))
		ifTrue: [ 
			"Continue evaluating"
			(bloc evaluate value) ifTrue: [ 
				"Inject code in the consequent block"
				(aMessage children at: 2) body  traceCr.
				aMessage parent replaceNode: aMessage  withNode: (aMessage children at: 2) body. 
				 ]
			ifFalse: [
				"Insert code at the alternative block"
				(aMessage children last) body traceCr.
				aMessage parent replaceNode: aMessage  withNode: (aMessage children last) body. 
				  ].
			
			]
		
		ifFalse: [
			CompileTimeConditionMustBeBoolean signal.
			]
		 ].
	super visitMessageNode: aMessage.
]
