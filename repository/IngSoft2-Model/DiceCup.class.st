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
	self validateAmountOfDice: dice.
	^ self new initializeWith: dice.
]

{ #category : #'instance creation' }
DiceCup class >> validateAmountOfDice: dice [
	dice size < 2
		ifTrue: [ Error signal: 'Dice cups must contain at least two dice' ].
]

{ #category : #'as yet unclassified' }
DiceCup >> amountOfDice [
	^ dice size.
]

{ #category : #initialization }
DiceCup >> initializeWith: diceSet [
	dice := diceSet
]

{ #category : #'as yet unclassified' }
DiceCup >> roll [
	^ dice sum: [ :die | die roll ].
]
