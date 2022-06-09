!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'initialPortfolio initialDeposit initialAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:19:49'!
createPortfolioWith: aBankingEntity	
	| listOfBankingEntities |
	
	listOfBankingEntities := OrderedCollection new.
	listOfBankingEntities add: aBankingEntity.
	^Portfolio with: listOfBankingEntities.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RP 6/8/2022 19:32:50'!
setUp
	
	| accounts |
	initialAccount := ReceptiveAccount new.
	accounts := OrderedCollection new.
	accounts add: initialAccount.
	initialDeposit := Deposit register: 50 * peso on: initialAccount.
	initialPortfolio := Portfolio with: accounts.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:09:10'!
test01AnEmptyPortfolioHasZeroBalance

	| aPortfolio listOfAccounts |
	
	listOfAccounts := OrderedCollection new.
	aPortfolio := Portfolio with: listOfAccounts.
	
	self assert: (aPortfolio balanceIs: 0*peso).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 12:48:06'!
test02APortfolioWithOneAccountHasCorrectBalance

	self assert: (initialPortfolio balanceIs: 50*peso).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:08:30'!
test03AnAccountCanBeAddedToAnExistingPortfolioAndBalanceIsCorrect

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount.
	initialPortfolio addBankingEntity: anAccount.
	
	self assert: (initialPortfolio balanceIs: 150*peso).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:12:26'!
test04APortfolioWithTwoAccountsHasCorrectBalance

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 * peso on: anAccount .
	initialPortfolio addBankingEntity: anAccount.
	
	self assert: (initialPortfolio balanceIs: 100*peso).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:10:05'!
test05ATransactionThatIsNotInThePortfolioIsNotFound

	| aDeposit anAccount |
	
	anAccount := ReceptiveAccount new.	
	aDeposit := Deposit register: 50*peso on: anAccount.

	self deny: (initialPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/7/2022 23:39:55'!
test06ATransactionThatIsInThePortfolioIsFound

	self assert: (initialPortfolio hasRegistered: initialDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:11:15'!
test07TransactionsOfAnAccountAreIncludedInAPortfolio

	| aWithdraw |

	aWithdraw := Withdraw register: 50 * peso on: initialAccount .
	
	self assert: ((initialPortfolio transactions) includes: initialDeposit ).
	self assert: ((initialPortfolio transactions) includes: aWithdraw ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:20:31'!
test08APortfolioHasAPortfolioWithAnAccountAndBalanceIsCorrect

	| aPortfolio |

	aPortfolio := self createPortfolioWith: initialPortfolio.
	
	self assert: (aPortfolio balanceIs: 50*peso).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:20:56'!
test09APortfolioHasAPortfolioWithAnAccountAndATransactionIsRegistered

	| aPortfolio |

	aPortfolio := self createPortfolioWith: initialPortfolio.
	
	self assert: (aPortfolio hasRegistered: initialDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:22:03'!
test10APortfolioHasAPortfolioWithAnAccountAndAllItsTransactionsAreRegistered

	| aPortfolio anAccount depositOfAnAccount withdrawOfAnAccount |
	
	anAccount := ReceptiveAccount new.
	depositOfAnAccount := Deposit register: 100*peso on: anAccount. 
	withdrawOfAnAccount := Withdraw register: 50*peso on: anAccount. 
	initialPortfolio addBankingEntity: anAccount.
	
	aPortfolio := self createPortfolioWith: initialPortfolio.

	self assert: ((aPortfolio transactions) includes: depositOfAnAccount).
	self assert: ((aPortfolio transactions) includes: withdrawOfAnAccount ).
	self assert: ((aPortfolio transactions) includes: initialDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:19'!
test11APortfolioCannotAddAnAlreadyRegisteredAccount
		
	self
		should: [initialPortfolio addBankingEntity: initialAccount]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio accountCanNotBeAddedToPortfolioErrorDescription].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:19'!
test12APortfolioCannotAddAnAlreadyRegisteredAccountInAnotherPortfolio

	| aPortfolio |
	
	aPortfolio := self createPortfolioWith: initialPortfolio.

	self
		should: [aPortfolio addBankingEntity: initialAccount ]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio accountCanNotBeAddedToPortfolioErrorDescription ].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:49'!
test13APortfolioCannotBeIncludedInItself

	self
		should: [initialPortfolio addBankingEntity: initialPortfolio]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio portfolioCannotBeAddedToPortfolioErrorDescription].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:49'!
test14APortfolioWithAnInitialPortfolioCannotAddTheSamePortfolio

	| aPortfolio |
	
	aPortfolio := self createPortfolioWith: initialPortfolio.
			
	self
		should: [aPortfolio addBankingEntity: initialPortfolio.]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio portfolioCannotBeAddedToPortfolioErrorDescription].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:49'!
test15AFatherPortfolioCannotAddAPortfolioThatIsAlreadyIncludedInTheChildPortfolio

	| anEmptyPortfolio anotherPortfolio listOfPortfolios |
	
	listOfPortfolios := OrderedCollection new.
	anEmptyPortfolio := Portfolio with: listOfPortfolios .
	initialPortfolio addBankingEntity: anEmptyPortfolio .
	
	anotherPortfolio := self createPortfolioWith: initialPortfolio.
		
	self
		should: [anotherPortfolio addBankingEntity: anEmptyPortfolio]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio portfolioCannotBeAddedToPortfolioErrorDescription].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:49'!
test16APortfolioCannotBeAddedToAnotherPortfolioThatIncludesAnAccountThatTheSecondOneAlreadyHas

	| aPortfolio |
	aPortfolio := self createPortfolioWith: initialAccount.
	
	self
		should: [initialPortfolio addBankingEntity: aPortfolio.]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio portfolioCannotBeAddedToPortfolioErrorDescription].
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:19'!
test17AnAccountCannotBeAddedToAPortfolioChildOfAPortfolioThatIncludesThatAccount

	| aChildPortfolio anEmptyList |
	
	anEmptyList := OrderedCollection new.
	aChildPortfolio := Portfolio with: anEmptyList .
	initialPortfolio addBankingEntity: aChildPortfolio .
	
	self
		should: [aChildPortfolio addBankingEntity: initialAccount.]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Portfolio accountCanNotBeAddedToPortfolioErrorDescription].
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:05:55'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 
	
	self assert: (account balanceIs: 0*peso).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:01'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
		
	self assert: (account balanceIs: 100*peso)
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:09'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: (account balanceIs: 50*peso)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:34'!
test04WithdrawValueMustBePositive 
	| withdrawValue |
	
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:26'!
test05ReceptiveAccountKnowsRegisteredTransactions 
	| deposit withdraw |
	
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:45'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions
	| deposit withdraw |
	
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'mr 6/9/2022 13:06:57'!
test07AccountKnowsItsTransactions 
	| deposit |
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).! !


!ReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:05:45'!
setUp
	account := ReceptiveAccount new.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'senderAccount receiverAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:00:01'!
setUp
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:04:10'!
test01TransferForAnAmmountOf0PesosCanBeMade
	
	Transfer send: 0*peso from: senderAccount to: receiverAccount.
	
	self verifySenderAccountBalanceIs: 0*peso andReceiverAccountBalanceIs: 0*peso. ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:04:39'!
test02AnAccountWith100PesosTransfersToAnotherOneWith0PesosAndBalancesAreCorrect

	Deposit register: 100*peso on: senderAccount.
	Transfer send: 50*peso from: senderAccount to: receiverAccount.
	
	self verifySenderAccountBalanceIs: 50*peso andReceiverAccountBalanceIs: 50*peso. ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:03:52'!
test03AnAccountWith100PesosTransfersToAnotherAccountWith100PesosAndBalancesAreCorrect

	Deposit register: 100*peso on: senderAccount.
	Deposit register: 100*peso on: receiverAccount.
	
	Transfer send: 50*peso from: senderAccount to: receiverAccount.
	
	self verifySenderAccountBalanceIs: 50*peso andReceiverAccountBalanceIs: 150*peso. ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:01:45'!
test05TransferDepositCounterpartIsTransferWithdraw
	| transfer |
	
	Deposit register: 100*peso on: senderAccount.
	transfer := Transfer send: 50*peso from: senderAccount to: receiverAccount.
	
	self assert: (transfer deposit) counterpart equals: transfer withdraw.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:04:29'!
test06TransferWithdrawCounterpartIsTransferDeposit
	| transfer |
	
	Deposit register: 100*peso on: senderAccount.
	transfer := Transfer send: 50*peso from: senderAccount to: receiverAccount.
	
	self assert: (transfer withdraw) counterpart equals: transfer deposit! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:02:10'!
test07AnAccountWithInsufficientFondsCanNotTransfer
		
	self
		should: [Transfer send: 50*peso from: senderAccount to: receiverAccount.]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = Transfer insufficientFundsErrorDescription].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:03:38'!
verifySenderAccountBalanceIs: aSenderAccountBalance andReceiverAccountBalanceIs: aReceiverAccountBalance
	self assert: (senderAccount balanceIs: aSenderAccountBalance).
	self assert: (receiverAccount balanceIs: aReceiverAccountBalance).

! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'public' stamp: 'rp 6/2/2022 21:36:34'!
affectBalance: aBalance
	self subclassResponsibility! !

!AccountTransaction methodsFor: 'public' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'rp 6/2/2022 21:08:40'!
register: aValue on: account

	| transaction |

	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'rp 6/2/2022 21:37:11'!
affectBalance: balanceActual
	
	^balanceActual + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'RP 6/8/2022 19:14:31'!
affectBalance: balanceActual
	
	^balanceActual + transfer ammountValue.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:36:41'!
counterpart
	^transfer withdraw.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:27:10'!
value
	^transfer ammountValue.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'rp 6/8/2022 15:51:51'!
initializeFor: aTransfer
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:33:50'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:33:23'!
register: aTransfer on: account

	| transaction |

	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'RP 6/8/2022 19:14:41'!
affectBalance: balanceActual
	
	^balanceActual - transfer ammountValue.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:36:57'!
counterpart
	^transfer deposit.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:27:27'!
value
	^transfer ammountValue.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'rp 6/8/2022 15:51:51'!
initializeFor: aTransfer
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:35:27'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:35:13'!
register: aTransfer on: account

	| transaction |

	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'rp 6/2/2022 21:37:12'!
affectBalance: balanceActual
	
	^balanceActual - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankingEntity category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #BankingEntity
	instanceVariableNames: 'fatherPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!BankingEntity methodsFor: 'public' stamp: 'mr 6/7/2022 21:25:55'!
balanceIs: anAmmount
	self subclassResponsibility.! !

!BankingEntity methodsFor: 'public' stamp: 'mr 6/7/2022 21:25:13'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!BankingEntity methodsFor: 'public' stamp: 'rp 6/8/2022 14:56:01'!
tansactions
	self subclassResponsibility.! !


!BankingEntity methodsFor: 'private' stamp: 'mr 6/8/2022 21:45:20'!
addFather: aFatherPortfolio
	fatherPortfolios add: aFatherPortfolio.! !

!BankingEntity methodsFor: 'private' stamp: 'mr 6/7/2022 21:27:00'!
balance
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
BankingEntity subclass: #Portfolio
	instanceVariableNames: 'bankingEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'RP 6/8/2022 19:19:35'!
balance
	^bankingEntities inject: 0*peso into: [:balance :aBankingEntity | balance + aBankingEntity balance ].
	! !

!Portfolio methodsFor: 'private' stamp: 'mr 6/9/2022 13:28:49'!
includesDirectly: aBankingEntity
	(bankingEntities includes: aBankingEntity) ifTrue: [
		self error: Portfolio portfolioCannotBeAddedToPortfolioErrorDescription
	].! !

!Portfolio methodsFor: 'private' stamp: 'mr 6/9/2022 12:45:50'!
verifyBankingEntityIsNotAlreadyIncluded: aBankingEntity
	self verifyBankingEntityIsNotRepeatedInHierarchy: aBankingEntity.! !

!Portfolio methodsFor: 'private' stamp: 'mr 6/9/2022 13:33:29'!
verifyBankingEntityIsNotRepeatedInHierarchy: aBankingEntity

	(self = aBankingEntity) ifTrue: [self error: Portfolio portfolioCannotBeAddedToPortfolioErrorDescription].
	
	bankingEntities do: [:eachBankingEntity | eachBankingEntity verifyBankingEntityIsNotAlreadyIncluded: aBankingEntity ].
	fatherPortfolios do: [:eachFather | eachFather verifyBankingEntityIsNotRepeatedInHierarchy: aBankingEntity ].
	! !


!Portfolio methodsFor: 'public' stamp: 'mr 6/9/2022 12:45:25'!
addBankingEntity: aBankingEntity
	self verifyBankingEntityIsNotRepeatedInHierarchy: aBankingEntity.

	aBankingEntity addFather: self.
	
	bankingEntities add: aBankingEntity. ! !

!Portfolio methodsFor: 'public' stamp: 'mr 6/7/2022 20:44:23'!
balanceIs: aBalance
	^self balance = aBalance.
	! !

!Portfolio methodsFor: 'public' stamp: 'mr 6/7/2022 21:33:10'!
hasRegistered: aTransaction
	^bankingEntities
		detect: [: aBankingEntity | aBankingEntity hasRegistered: aTransaction ] 
	 	ifFound: [: aBankingEntity | true]
		ifNone: [false].! !

!Portfolio methodsFor: 'public' stamp: 'rp 6/8/2022 15:09:35'!
transactions

	| listOfTransactions | 
	listOfTransactions := OrderedCollection new.
	
	bankingEntities do: [: aBankingEntity | 
		listOfTransactions addAll: (aBankingEntity transactions)].
	
	^listOfTransactions.
	
	! !


!Portfolio methodsFor: 'initialization' stamp: 'mr 6/8/2022 21:57:56'!
initializeFor: aBankingEntities
	bankingEntities := aBankingEntities.
	fatherPortfolios := OrderedCollection new.
	bankingEntities do: [: aBankingEntity | aBankingEntity addFather: self].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:32'!
accountCanNotBeAddedToPortfolioErrorDescription
	^'The account can not be added to the portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/9/2022 13:28:58'!
portfolioCannotBeAddedToPortfolioErrorDescription
	^'Portfolio cannot be added to the portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:51:52'!
with: aBankingEntities
	^self new initializeFor: aBankingEntities.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
BankingEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'mr 6/8/2022 21:46:42'!
initialize
	transactions := OrderedCollection new.
	fatherPortfolios := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'private' stamp: 'RP 6/8/2022 19:18:55'!
balance

	^transactions inject: 0*peso into: [:balance :aTransaction | aTransaction affectBalance: balance ].! !

!ReceptiveAccount methodsFor: 'private' stamp: 'mr 6/9/2022 13:28:19'!
includesDirectly: anAccount.
	(self = anAccount) ifTrue: [self error: Portfolio accountCanNotBeAddedToPortfolioErrorDescription ]! !

!ReceptiveAccount methodsFor: 'private' stamp: 'mr 6/9/2022 12:46:25'!
verifyBankingEntityIsNotAlreadyIncluded: aBankingEntity
	aBankingEntity includesDirectly: self.
! !


!ReceptiveAccount methodsFor: 'public' stamp: 'mr 6/7/2022 21:26:32'!
balanceIs: anAmmount
	^anAmmount = self balance.! !

!ReceptiveAccount methodsFor: 'public' stamp: 'mr 6/9/2022 12:18:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'public' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'public' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'senderAccount receiverAccount ammountTransfered deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'public' stamp: 'mr 6/7/2022 20:02:35'!
ammountValue
	^ammountTransfered.! !

!Transfer methodsFor: 'public' stamp: 'mr 6/7/2022 23:12:39'!
deposit
	^deposit.! !

!Transfer methodsFor: 'public' stamp: 'mr 6/7/2022 23:12:54'!
withdraw
	^withdraw.! !


!Transfer methodsFor: 'initialization' stamp: 'rp 6/8/2022 15:37:33'!
initializeWith: anAmmount from: aSenderAccount to: aReceiverAccount

	senderAccount := aSenderAccount.
	receiverAccount := aReceiverAccount.
	ammountTransfered := anAmmount.
	
	deposit := TransferDeposit register: self on: receiverAccount .
	withdraw := TransferWithdraw register: self on: senderAccount. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'mr 6/7/2022 20:29:16'!
insufficientFundsErrorDescription
	^'Insufficient funds'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:45:21'!
send: anAmmount from: aSenderAccount to: aReceiverAccount

	self verify: aSenderAccount hasMoreMoneyThan: anAmmount.
	^self new initializeWith: anAmmount from: aSenderAccount to: aReceiverAccount.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rp 6/8/2022 15:55:36'!
verify: aSenderAccount hasMoreMoneyThan: anAmmountOfMoney
	((aSenderAccount balance) < anAmmountOfMoney) ifTrue: [self error: Transfer insufficientFundsErrorDescription].

! !
