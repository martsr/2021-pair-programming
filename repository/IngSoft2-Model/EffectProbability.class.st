Class {
	#name : #EffectProbability,
	#superclass : #Object,
	#instVars : [
		'effect',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectProbability class >> of: anEffect with: aProbability [
	^self new initializeOf: anEffect with: aProbability 
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
