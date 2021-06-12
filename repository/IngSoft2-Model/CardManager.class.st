Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'gamePlayers',
		'playerHands',
		'activePlays',
		'playHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> using: aDeck dealsTo: aGroupOfPlayers [ 
	^self new initializeUsing: aDeck dealsTo: aGroupOfPlayers
]

{ #category : #action }
CardManager >> activate: aPlay [ 
	
	self removeFromPlayerHandCardOf: aPlay.  
	activePlays add: aPlay.
	
]

{ #category : #action }
CardManager >> activate: aCard by: invokingPlayer directedTo: aTarget [

	| appliedCard aPlay |
	appliedCard := self remove: aCard fromHandOf: invokingPlayer. 
	aPlay := Play madeBy: appliedCard directedTo: aTarget calledBy: invokingPlayer. 
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

{ #category : #'as yet unclassified' }
CardManager >> deal: aCard to: invokingPlayer [
	
	| playerHand |
	
	playerHand := playerHands at: invokingPlayer .
	playerHand add: aCard.
	playerHands at: invokingPlayer put: playerHand.
]

{ #category : #action }
CardManager >> dealStartingCards [
	| playerHand |
	gamePlayers
		do: [ :player | playerHand := OrderedCollection newFrom: { deck draw . deck draw }. playerHands at: player put: playerHand ]
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
	playHistory := OrderedCollection newFrom: { Play madeBy: (NoEffectCard new) directedTo: players calledBy: (players first) }.
	self dealStartingCards.
]

{ #category : #initialization }
CardManager >> playHistory [
	^ playHistory copy.
]

{ #category : #removing }
CardManager >> remove: aCard fromHandOf: invokingPlayer [
	
	| playedCard invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: invokingPlayer.
	playedCard := invokingPlayerHand remove: aCard ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: invokingPlayer put: invokingPlayerHand.
	playHistory add: playedCard.
	^ playedCard.
]

{ #category : #action }
CardManager >> removeFromActivePlays: targetedPlay [ 

	| foundPlay |
	
	self verfiyThereAreActivePermanentCards.
	foundPlay := activePlays detect: [ :aPlay | aPlay = targetedPlay ] ifNone: [ Error signal: 'The targeted card by the cancellation card is not active' ]. 
	activePlays remove: foundPlay.
]

{ #category : #removing }
CardManager >> removeFromPlayerHandCardOf: aPlay [

	| playedCard invokingPlayerHand |
	
	invokingPlayerHand := playerHands at: (aPlay invokingPlayer).
	playedCard := invokingPlayerHand remove: (aPlay card) ifAbsent: [ Error signal:  'A card must be in the invoking player hand to be played' ].
	playerHands at: (aPlay invokingPlayer) put: invokingPlayerHand.
	playHistory add: aPlay.
	^ playedCard.
]

{ #category : #removing }
CardManager >> verfiyThereAreActivePermanentCards [
	activePlays size < 1
		ifTrue: [ Error
				signal:
					'Cancellation cannot be applied when there are no active permanent cards' ]
]
