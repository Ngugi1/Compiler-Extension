Class {
	#name : #LoopUnroller,
	#superclass : #IRVisitor,
	#category : #'META-Project-sngugi'
}

{ #category : #'as yet unclassified' }
LoopUnroller >> loopLength: aSequence [
	(aSequence at: 2) isPushLiteral 
	ifTrue: [ ^ (aSequence at: 2) literal ]. "Get the sencond instruction"
]

{ #category : #'as yet unclassified' }
LoopUnroller >> unroll: ir [
	"Change the IR here"
	| pushInstr  seqSize loopBody incrementValue jumpInstr|
	ir children do: [ :sequence |
		sequence last isJump ifTrue: [ 
			sequence last destination orderNumber < sequence orderNumber ifTrue: [ 
				"loopSize := self loopLength: (sequence last destination)."
				"Unroll all of the loop"
				jumpInstr := sequence last.
				sequence remove: (sequence last).
				seqSize := sequence children size.
				pushInstr := sequence children at: (seqSize - 3). "This is the instruction that indicates the increment"
				pushInstr isPushLiteral ifTrue: [ 
					incrementValue := pushInstr literal.
					pushInstr literal: 1.
					 ].
				loopBody  := sequence children.
				"Change the increment of the by"
				1 to: incrementValue do: [ :x | 
					sequence addInstructions: (loopBody). "Duplicate loop body"
					 ].
				sequence addLast: jumpInstr.
				 ]
			]
		 ].
	^ ir.
	
]
