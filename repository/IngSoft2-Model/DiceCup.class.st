Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> containing: dice [
	self validateAmountOfDice: dice.
	^ self new initializeContaining: dice
]

{ #category : #'instance creation' }
DiceCup class >> containingSingle: aDie [ 
	^self containing: {aDie}.
]

{ #category : #validation }
DiceCup class >> validateAmountOfDice: dice [
	dice size < 1
		ifTrue: [ Error signal: 'Dice cups must contain at least a die' ]
]

{ #category : #accessing }
DiceCup >> amountOfDice [
	^ dice size
]

{ #category : #initialization }
DiceCup >> initializeContaining: diceSet [
	dice := diceSet
]

{ #category : #action }
DiceCup >> throw [
	^ dice sumNumbers: [ :die | die throw ]
]
