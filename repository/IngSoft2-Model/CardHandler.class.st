Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activePlays',
		'playHistory',
		'activeReversePlays'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardHandler class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardHandler >> activate: aPlay on: aBoard [ 
	
	self removeFromPlayerHandCardOf: aPlay.  
	(aPlay card) handleActivationOf: aPlay on: aBoard. 

	
]

{ #category : #accessing }
CardHandler >> activeCards [
	
	| activeCards |
	
	activeCards := activePlays collect: [ :play | play card ].
	^ activeCards copy
]

{ #category : #accessing }
CardHandler >> activePlays [
	^ activePlays copy
]

{ #category : #accessing }
CardHandler >> activeReversePlays [
	
	| activeReverseCards |
	
	activeReverseCards := activeReversePlays collect: [ :play | play card ].
	^ activeReverseCards copy
]

{ #category : #adding }
CardHandler >> addToActivePlays: aPlay [ 
activePlays add: aPlay
]

{ #category : #adding }
CardHandler >> addToReversePlays: aPlay [ 
	activeReversePlays add: aPlay. 
]

{ #category : #action }
CardHandler >> deal: aCard to: invokingPlayer [
	
	| playerHand |
	
	playerHand := playerHands at: invokingPlayer.
	playerHand add: aCard.
	playerHands at: invokingPlayer put: playerHand
]

{ #category : #action }
CardHandler >> dealStartingCards [

	| playerHand |
	
	gamePlayers
		do: [ :player | playerHand := OrderedCollection newFrom: { deck draw . deck draw }. 
			 playerHands at: player put: playerHand ]
]

{ #category : #action }
CardHandler >> dealsCardTo: aPlayer [
	
	| playerHand drawnCard |
	
	playerHand := playerHands at: aPlayer.
	drawnCard := deck draw.
	playerHand add: drawnCard.
	playerHands at: aPlayer put: playerHand
]

{ #category : #accessing }
CardHandler >> handOf: aPlayer [
	
	| playerHand |
	
	playerHand := (playerHands at: aPlayer) asOrderedCollection.
	^ playerHand
]

{ #category : #initialization }
CardHandler >> initializeUsing: aDeck dealsTo: players [

	deck := aDeck.
	gamePlayers := players.
	playerHands := Dictionary new.
	activePlays := OrderedCollection new.
	activeReversePlays := OrderedCollection new.
	playHistory := OrderedCollection new.
	self dealStartingCards
]

{ #category : #initialization }
CardHandler >> playHistory [
	^ playHistory copy
]

{ #category : #action }
CardHandler >> removeFromActivePlays: targetedPlay [ 

	| foundPlay |
	
	self verfiyThereAreActivePermanentCards.
	foundPlay := activePlays detect: [ :aPlay | aPlay = targetedPlay ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	activePlays remove: foundPlay
]

{ #category : #removing }
CardHandler >> removeFromPlayerHandCardOf: aPlay [

	| invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: (aPlay invokingPlayer).
	invokingPlayerHand remove: (aPlay card) ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: (aPlay invokingPlayer) put: invokingPlayerHand.
	playHistory add: aPlay.
]

{ #category : #removing }
CardHandler >> removeFromReversePlays: targetedPlay [
| foundPlay |
	self verfiyThereAreActiveReverseCards.
	foundPlay := activeReversePlays  detect: [ :aPlay | (aPlay target) = (targetedPlay target)] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	activeReversePlays:= activeReversePlays reject:[:reverseCard | (reverseCard target)= (foundPlay target) ]
]

{ #category : #removing }
CardHandler >> verfiyThereAreActivePermanentCards [
	activePlays size < 1 ifTrue: [ Error signal: 'Cancellation cannot be applied when there are no active permanent cards' ]
]

{ #category : #removing }
CardHandler >> verfiyThereAreActiveReverseCards [
activeReversePlays  size < 1 ifTrue: [ Error signal: 'Cancellation card cannot be applied when there are no active reverse cards.' ]
]
