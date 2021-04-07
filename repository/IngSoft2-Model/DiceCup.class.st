Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> contains: dice [ 
	^self new initializeWith: dice .
]

{ #category : #'as yet unclassified' }
DiceCup >> amountOfDice [
	^dice size.
]

{ #category : #initialization }
DiceCup >> initializeWith: diceSet [ 
dice := diceSet.
]
