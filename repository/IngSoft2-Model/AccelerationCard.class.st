Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AccelerationCard >> applyTo: aBoard [

	target do: [ :aPlayer | aBoard move: aPlayer by: 1].
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true.
]

{ #category : #accessing }
AccelerationCard >> target [
	^ target.
]

{ #category : #action }
AccelerationCard >> targets: aPlayer [
	target := aPlayer.
]
