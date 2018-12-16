Class {
	#name : #LoopUnrollTest,
	#superclass : #Object,
	#category : #'META-Project-sngugi'
}

{ #category : #compiler }
LoopUnrollTest class >> compiler [
	| comp |
	comp := super compiler.
	comp compilationContext astTranslatorClass: LoopUnrollASTTranslator.
	^ comp
]

{ #category : #'as yet unclassified' }
LoopUnrollTest >> controlCond [
	1 to: 100  by: 2 do: [ :i | (i + 1) traceCr].
]

{ #category : #accessing }
LoopUnrollTest >> test [
	1 _to: 100  unrollBy: 2 do: [ :i | (i + 1) traceCr].
]
