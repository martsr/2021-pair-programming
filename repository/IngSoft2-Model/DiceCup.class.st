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
	^ self new initializeWith: dice
]

{ #category : #'instance creation' }
DiceCup class >> containsSingle: aDie [ 
	^self new initializeWith: {aDie}
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
DiceCup >> initializeWith: diceSet [
	dice := diceSet
]

{ #category : #diceCupAction }
DiceCup >> throw [
	^ dice sum: [ :die | die throw ]
]
