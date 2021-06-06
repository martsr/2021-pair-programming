Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true.
]

{ #category : #action }
SpeedCard >> targets: aPlayer [

	target := aPlayer.
]
