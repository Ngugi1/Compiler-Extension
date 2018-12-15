Class {
	#name : #LoopUnrollASTTranslator,
	#superclass : #OCASTTranslator,
	#category : #'META-Project-sngugi'
}

{ #category : #accessing }
LoopUnrollASTTranslator >> ir [
	| ir |
	ir := super ir.
	ir := LoopUnroller new unroll: ir.
	ir children do: [:child | child children traceCr ].
	^ ir
]

{ #category : #'visitor-double dispatching' }
LoopUnrollASTTranslator >> visitNode: aNode [ 
|params|
	aNode allChildren do: [:child | 
		child isMessage ifTrue: [
			child selector = '_to:unrollBy:do:' ifTrue: [
				params := (RBMessageNode receiver: child receiver  selector: 'to:by:do:'  arguments: child arguments). 
				child parent replaceNode: child withNode: params.
				].
			]].
	super visitNode: aNode.
]
