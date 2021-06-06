Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpeedCard >> applyTo: aBoard [

	aBoard move: target by: 1.
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true.
]

{ #category : #accessing }
SpeedCard >> target [
	^ target.
]

{ #category : #action }
SpeedCard >> targets: aPlayer [

	target := aPlayer.
]
