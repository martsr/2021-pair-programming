Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
OverloadCard >> isPermanent [
	^ true.
]

{ #category : #action }
OverloadCard >> targets: aPlayer [
	target := aPlayer.
]
