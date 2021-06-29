Class {
	#name : #EffectShufflerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
EffectShufflerTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
EffectShufflerTest >> test01EffectShufflerCannotGenerateSquaresWIthoutEffectDistributions [
	
	self 
		should: [ EffectShuffler ofSize: 20 withGiven: { } ]
		raise: Error
		withMessage: 'Squares cannot be generated without effect distributions'.
]

{ #category : #tests }
EffectShufflerTest >> test02EffectShufflerCannotGenerateSquaresIfSumOfProbabilitesIsLessThanOne [

	|  effectsDistribution  |

	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.3.EffectProbability of: WormHoleEffect  new with: 0.20 	.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: 	AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	self 
		should: [ EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy) ]
		raise: Error
		withMessage: 'Sum of effect probabilities must be equal to 1'.
]

{ #category : #tests }
EffectShufflerTest >> test03EffectShufflerCannotGenerateSquaresIfSumOfProbabilitesIsMoreThanOne [

	| effectsDistribution |
	
	effectsDistribution := OrderedCollection newFrom: { EffectProbability of: NoEffect new with: 0.5.EffectProbability of: WormHoleEffect  new with: 0.20 		.EffectProbability of: SpeedUpEffect  new with: 0.20 .EffectProbability of: 	AtomicBombEffect  new with: 0.02. EffectProbability of: (MoonWalkEffect goingBack: 3) with: 0.10}.
	self 
		should: [ EffectShuffler ofSize: 20 withGiven: (effectsDistribution copy) ]
		raise: Error
		withMessage: 'Sum of effect probabilities must be equal to 1'.
]
