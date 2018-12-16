Class {
	#name : #LoopUnrollTestCase,
	#superclass : #TestCase,
	#category : #'META-Project-sngugi'
}

{ #category : #tests }
LoopUnrollTestCase >> testUnroll [
	((LoopUnrollTest>>#test) ast ir children at: 3) children size traceCr.
	((LoopUnrollTest >>#controlCond) ast ir children at: 3) children size traceCr.
	
]
