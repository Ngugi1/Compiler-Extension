Class {
	#name : #AssertionTestCase,
	#superclass : #TestCase,
	#category : #'META-Project-sngugi'
}

{ #category : #tests }
AssertionTestCase >> testAssert [
"Under debug mode, this test fails."
"Change return value of Assert>>debugMode to false and this test will fail"
|messageNodes|
messageNodes := (AssertTest>>#test) ast allChildren select: [:child | child isMessage].
self assert: ((messageNodes select: [:message | message selector = 'assert:']) size) equals: 0.
]
