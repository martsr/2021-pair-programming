Class {
	#name : #EffectProbabilityTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
EffectProbabilityTest >> should: errorBlock raise: exceptionClass withMessage: expectedErrorMessage [

	self
		should: errorBlock
		raise: exceptionClass
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedErrorMessage ]
]

{ #category : #tests }
EffectProbabilityTest >> test01EffectProbabilityCannotBeGreaterThanOne [

	| effect |

	effect := NoEffect new.
	self 
		should: [ EffectProbability of: effect with: 1.01 ]
		raise: Error
		withMessage: 'Effect probability must be greater than zero and less than one'.
]

{ #category : #tests }
EffectProbabilityTest >> test02EffectProbabilityCannotBeLessThanZero [

	| effect |

	effect := NoEffect new.
	self 
		should: [ EffectProbability of: effect with: -0.01 ]
		raise: Error
		withMessage: 'Effect probability must be greater than zero and less than one'.
]
