Class {
	#name : #EffectProbability,
	#superclass : #Object,
	#instVars : [
		'effect',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectProbability class >> of: anEffect with: aProbability [
	self validateIsGreaterThanZeroAndLessThanOne: aProbability.
	^self new initializeOf: anEffect with: aProbability 
]

{ #category : #validation }
EffectProbability class >> validateIsGreaterThanZeroAndLessThanOne: aProbability [

	(aProbability >= 1 or: aProbability <= 0) ifTrue: [ Error signal: 'Effect probability must be greater than zero and less than one' ].
]

{ #category : #comparing }
EffectProbability >> < anEffectProbability [
	^ probability < (anEffectProbability probability). 
]

{ #category : #accessing }
EffectProbability >> effect [
	^effect.
]

{ #category : #initialization }
EffectProbability >> initializeOf: anEffect with: aProbability [

	effect := anEffect.
	probability := aProbability.
]

{ #category : #accessing }
EffectProbability >> probability [
	^probability.
]
