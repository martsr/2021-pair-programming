Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
OverloadCard >> applyTo: aBoard [

	aBoard move: target by: -2.
]

{ #category : #accessing }
OverloadCard >> isPermanent [
	^ true.
]

{ #category : #accessing }
OverloadCard >> target [ 
	^ target.
]

{ #category : #action }
OverloadCard >> targets: aPlayer [
	target := aPlayer.
]
