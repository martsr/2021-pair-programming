Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activePlays'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardManager >> activate: aCard by: invokingPlayer directedTo: aTarget [

	| appliedCard aPlay |
	appliedCard := self remove: aCard fromHandOf: invokingPlayer. 
	aPlay := Play madeBy: appliedCard directedTo: aTarget. 
	activePlays add: aPlay.
	
]

{ #category : #accessing }
CardManager >> activeCards [
	
	| activeCards |
	
	activeCards := activePlays collect: [ :play | play card ].
	^ activeCards copy.
]

{ #category : #accessing }
CardManager >> activePlays [

	^ activePlays copy.
]

{ #category : #action }
CardManager >> dealStartingCards [
	| playerHand |
	gamePlayers
		do: [ :player | 
			playerHand := OrderedCollection newFrom: { deck draw . deck draw }.
			playerHands at: player put: playerHand ]
]

{ #category : #action }
CardManager >> dealsCardTo: aPlayer [
	
	| playerHand drawnCard |
	
	playerHand := playerHands at: aPlayer.
	drawnCard := deck draw.
	playerHand add: drawnCard.
	playerHands at: aPlayer put: playerHand.
]

{ #category : #accessing }
CardManager >> handOf: aPlayer [
	
	| playerHand |
	
	playerHand := (playerHands at: aPlayer) asOrderedCollection.
	^ playerHand.
]

{ #category : #initialization }
CardManager >> initializeUsing: aDeck dealsTo: players [
	deck := aDeck.
	gamePlayers := players.
	playerHands := Dictionary new.
	activePlays := OrderedCollection new.
	self dealStartingCards.
]

{ #category : #removing }
CardManager >> remove: aPermanentCard affecting: aPlayer [
	
	| targetedPlay temporaryPlay |
	
	self verfiyThereAreActivePermanentCards.
	temporaryPlay := Play madeBy: aPermanentCard directedTo: aPlayer.
	targetedPlay := activePlays detect: [ :aPlay | aPlay = temporaryPlay ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	"targetedPlay := activePlays detect: [ :aPlay | aPermanentCard = (aPlay card) and: (aPlay directedTo: aPlayer) ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]."
	activePlays remove: targetedPlay.
]

{ #category : #removing }
CardManager >> remove: aCard fromHandOf: invokingPlayer [
	
	| playedCard invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: invokingPlayer.
	playedCard := invokingPlayerHand remove: aCard ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: invokingPlayer put: invokingPlayerHand.
	^ playedCard.
]

{ #category : #action }
CardManager >> removeFromActivePlays: targetedPlay [ 

	| foundPlay |
	
	self verfiyThereAreActivePermanentCards.
	foundPlay := activePlays detect: [ :aPlay | ((aPlay card) = (targetedPlay card)) and:((aPlay target) includesAll: (targetedPlay target)) ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	activePlays remove: foundPlay.
]

{ #category : #removing }
CardManager >> verfiyThereAreActivePermanentCards [
	activePlays size < 1
		ifTrue: [ Error
				signal:
					'Cancellation cannot be applied when there are no active permanent cards' ]
]
