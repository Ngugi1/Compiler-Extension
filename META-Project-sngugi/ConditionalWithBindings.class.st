Class {
	#name : #ConditionalWithBindings,
	#superclass : #Object,
	#classInstVars : [
		'Bits64'
	],
	#category : #'META-Project-sngugi'
}

{ #category : #adding }
ConditionalWithBindings class >> addCompileTimeVariables [
        <constantDefinition>
        ^ { 'Bits64' -> true .
                'Bits' -> 64 .
                'Bits32' -> false } asDictionary.
]

{ #category : #compiler }
ConditionalWithBindings class >> compiler [
|compiler|
	compiler := super compiler.
	compiler compilationContext semanticAnalyzerClass: ConditionalWithBindingsSemanticAnalyser.
	^ compiler 
]

{ #category : #tests }
ConditionalWithBindings >> test: val [
<constantDefinition>
	[1 = 1] _ifTrue: [  'okay' traceCr. 'hello' traceCr ] 
ifFalse: ['We are false' traceCr]
]
