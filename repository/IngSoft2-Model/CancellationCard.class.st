Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: aPermanentCard affecting: aPlayer [.
	aBoard applyCancellationCardTo: aPermanentCard affecting: aPlayer.
]

{ #category : #accessing }
CancellationCard >> isPermanent [
	^ false.
]
