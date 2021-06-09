Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyTo: aBoard directedTo: anEffect affecting: aPlayer [.
	aBoard applyRepeatCardTo: anEffect affecting: aPlayer.
]

{ #category : #accessing }
RepeatCard >> isPermanent [
	^ false.
]
