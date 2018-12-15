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

{ #category : #accessing }
LoopUnrollTest >> test [
	1 _to: 10000  unrollBy: 2 do: [ :i | (i + 1) traceCr].
]
