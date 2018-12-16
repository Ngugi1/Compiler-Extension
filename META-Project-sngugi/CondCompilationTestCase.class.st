Class {
	#name : #CondCompilationTestCase,
	#superclass : #TestCase,
	#category : #'META-Project-sngugi'
}

{ #category : #tests }
CondCompilationTestCase >> testConditionalCompilation [
"Confirm that our test method has no RBMessageNodes since we did a conditional compilation"
	|astNodes|
	astNodes := (ConditionalCompilationTest>>#test) ast allChildren select:[  :child | child isMessage].
	self assert: (astNodes size) equals: 0.
]
