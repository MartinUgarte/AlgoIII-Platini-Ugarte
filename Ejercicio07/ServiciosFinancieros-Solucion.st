!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'rp 6/11/2022 16:04:51'!
assertReportOf: anAccount isEqualTo: anExpectedReport
	| anAccountSummary |
	anAccountSummary := AccountSummary of: anAccount.
	
	self assert: anExpectedReport equals: anAccountSummary report.! !


!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:40'!
test01SummaryOfAnAccountWithoutTransactionsIndicatesZeroBalance
	| anAccount expectedReport |
	
	anAccount := ReceptiveAccount new.
	
	expectedReport := {'Balance = 0 pesos'} asOrderedCollection.
	
	self assertReportOf: anAccount isEqualTo: expectedReport.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:37'!
test02SummaryOfAnAccountWithADepositIndicatesTheTransactionAndBalance
	| anAccount expectedReport |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount.
	
	expectedReport := {'Deposito por 100 pesos'. 'Balance = 100 pesos'} asOrderedCollection.
	
	self assertReportOf: anAccount isEqualTo: expectedReport.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:34'!
test03SummaryOfAnAccountWithAWithdrawAnADepositIndicatesTheTransactionsAndBalance
	| anAccount expectedReport |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount.
	Withdraw register: 20*peso on: anAccount.
	
	expectedReport := {'Deposito por 100 pesos'. 'Extraccion por 20 pesos'. 'Balance = 80 pesos'} asOrderedCollection.
	
	self assertReportOf: anAccount isEqualTo: expectedReport.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:31'!
test04SummaryOfAnOriginAccountWithATransferIndicatesTheTransactionsAndBalance
	| originAccount destinationAccount expectedReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: originAccount.
	
	Transfer amount: 30 * peso from: originAccount to: destinationAccount.
	
	expectedReport := {'Deposito por 100 pesos'. 'Salida por transferencia de 30 pesos'. 'Balance = 70 pesos'} asOrderedCollection.
	
	self assertReportOf: originAccount isEqualTo: expectedReport.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:28'!
test05SummaryOfADestinationAccountWithATransferIndicatesTheTransactionAndBalance
	| originAccount destinationAccount expectedReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: originAccount.
	
	Transfer amount: 30 * peso from: originAccount to: destinationAccount.
	
	expectedReport := {'Entrada por transferencia de 30 pesos'. 'Balance = 30 pesos'} asOrderedCollection.
	
	self assertReportOf: destinationAccount isEqualTo: expectedReport.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:25'!
test06SummaryOfAPortfolioWithAReceptiveAccountWithADepositIndicatesTheTransactionAndBalance
	| aPortfolio aReceptiveAccount expectedReport |
	
	aReceptiveAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: aReceptiveAccount .
	
	aPortfolio := Portfolio with: aReceptiveAccount.
	expectedReport := {'Deposito por 100 pesos'. 'Balance = 100 pesos'} asOrderedCollection.
	
	self assertReportOf: aPortfolio isEqualTo: expectedReport.
	
	
	
	! !

!ReportTest methodsFor: 'test' stamp: 'rp 6/11/2022 16:29:09'!
test07SummaryOfAPortfolioWithTwoAccountsIndicatesTheTransactionsAndBalance
	| aPortfolio anOriginReceptiveAccount aDestinationReceptiveAccount expectedReport |
	
	anOriginReceptiveAccount := ReceptiveAccount new.
	aDestinationReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: anOriginReceptiveAccount .
	Transfer amount: 30*peso from: anOriginReceptiveAccount to: aDestinationReceptiveAccount.
	
	aPortfolio := Portfolio with: anOriginReceptiveAccount with: aDestinationReceptiveAccount.
	
	expectedReport := {'Deposito por 100 pesos'. 'Salida por transferencia de 30 pesos'. 'Entrada por transferencia de 30 pesos'. 'Balance = 100 pesos'} asOrderedCollection.
	
	self assertReportOf: aPortfolio isEqualTo: expectedReport.
	
	
	
	! !

!ReportTest methodsFor: 'test' stamp: 'rp 6/11/2022 16:33:07'!
test08SummaryOfAPortfolioWithAPortfolioIndicatesTheTransactionsAndBalance
	| aPortfolio aPortfolioWithAPortfolio aReceptiveAccount expectedReport |
	
	aReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: aReceptiveAccount.
	Withdraw register: 10*peso on: aReceptiveAccount.
	
	aPortfolio := Portfolio with: aReceptiveAccount.
	aPortfolioWithAPortfolio := Portfolio with: aPortfolio.
	
	expectedReport := {'Deposito por 100 pesos'. 'Extraccion por 10 pesos'. 'Balance = 90 pesos'} asOrderedCollection.
	
	self assertReportOf: aPortfolioWithAPortfolio isEqualTo: expectedReport.
	
	
	
	! !

!ReportTest methodsFor: 'test' stamp: 'rp 6/13/2022 20:10:24'!
test09TransferNetOfAReceptiveAccountWithoutTransfersIsZero
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.

	transferNet := TransferNet of: anAccount.
	
	self assert: (0*peso) equals: transferNet report.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/12/2022 20:18:19'!
test10TransferNetOfAReceptiveAccountWithATransferIsCorrect
	| anOriginReceptiveAccount aDestinationReceptiveAccount transferNet |
	
	anOriginReceptiveAccount := ReceptiveAccount new.
	aDestinationReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: anOriginReceptiveAccount.
	
	Transfer amount: 30 * peso from: anOriginReceptiveAccount to: aDestinationReceptiveAccount.
	transferNet := TransferNet of: anOriginReceptiveAccount.
	
	self assert: (30*peso) negated equals: transferNet report.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/12/2022 20:19:09'!
test11TransferNetOfAPortfolioWithATransferIsCorrect
	| aPortfolio anOriginReceptiveAccount aDestinationReceptiveAccount transferNet |
	
	anOriginReceptiveAccount := ReceptiveAccount new.
	aDestinationReceptiveAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anOriginReceptiveAccount.
	
	Deposit register: 100*peso on: anOriginReceptiveAccount.
	Transfer amount: 40 * peso from: anOriginReceptiveAccount to: aDestinationReceptiveAccount.
	transferNet := TransferNet of: aPortfolio.
	
	self assert: (40*peso) negated equals: transferNet report.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/12/2022 20:19:51'!
test12TransferNetOfAPortfolioWithManyTransfersIsCorrect
	| aPortfolio anOriginReceptiveAccount aDestinationReceptiveAccount anotherReceptiveAccount transferNet |
	
	anOriginReceptiveAccount := ReceptiveAccount new.
	aDestinationReceptiveAccount := ReceptiveAccount new.
	anotherReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: anOriginReceptiveAccount.
	Transfer amount: 40 * peso from: anOriginReceptiveAccount to: aDestinationReceptiveAccount.
	Transfer amount: 10 * peso from: anotherReceptiveAccount to: anOriginReceptiveAccount .
	
	aPortfolio := Portfolio with: anOriginReceptiveAccount.
	
	transferNet := TransferNet of: aPortfolio.
	
	self assert: (30*peso) negated equals: transferNet report.
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:15'!
test13TreePrinterOfAnEmptyPortfolioIndicatesExpectedReport
	| aPortfolio aTreePrinter expectedTree |
	
	aPortfolio := Portfolio named: 'Empty Portfolio' .
	aTreePrinter := PortfolioTreePrinter of: aPortfolio.
	expectedTree := {'Empty Portfolio'} asOrderedCollection. 
	
	self assert: expectedTree equals: aTreePrinter report.! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 22:44:42'!
test14TreePrinterOfAPortfolioWithAReceptiveAccountIndicatesExpectedReport
	| aReceptiveAccount aPortfolio aTreePrinter expectedTree |
	
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	aPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount .
	aTreePrinter := PortfolioTreePrinter of: aPortfolio.
	
	expectedTree := {'Root Portfolio'. ' Rocio'} asOrderedCollection. 
	
	self assert: expectedTree equals: aTreePrinter report.! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:37:11'!
test15TreePrinterOfAPortfolioWithManyAccountsIndicatesExpectedReport
	| aReceptiveAccount aRootPortfolio aChildPortfolio aTreePrinter expectedTree |
	
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	aChildPortfolio := Portfolio named: 'Child Portfolio'.
	aRootPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount with: aChildPortfolio.
	
	aTreePrinter := PortfolioTreePrinter of: aRootPortfolio.
	expectedTree := {'Root Portfolio'. ' Rocio'. ' Child Portfolio'} asOrderedCollection. 
	
	self assert: expectedTree equals: aTreePrinter report.! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:38:38'!
test16TreePrinterOfAPortfolioWithAPortfolioWithAccountsIndicatesExpectedReport
	| aReceptiveAccount aSecondReceptiveAccount aThirdReceptiveAccount aRootPortfolio aChildPortfolio aTreePrinter expectedTree |
	
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	aSecondReceptiveAccount := ReceptiveAccount named: 'Martin'.
	aThirdReceptiveAccount := ReceptiveAccount named: 'Juan'.
	
	aChildPortfolio := Portfolio named: 'Child Portfolio' with: aSecondReceptiveAccount with: aThirdReceptiveAccount.
	aRootPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount with: aChildPortfolio.
	
	aTreePrinter := PortfolioTreePrinter of: aRootPortfolio.
	expectedTree := {'Root Portfolio'. ' Rocio'. ' Child Portfolio'. '  Martin'. '  Juan'} asOrderedCollection. 
	
	self assert: expectedTree equals: aTreePrinter report.! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/15/2022 23:56:19'!
test17DetailedTreePrinterOfAnEmptyPortfolioIndicatesExpectedReport
	| aRootPortfolio aDetailedTreePrinter expectedReport |
	
	aRootPortfolio := Portfolio named: 'Root Portfolio'.
	aDetailedTreePrinter := PortfolioDetailedTreePrinter of: aRootPortfolio.
	
	expectedReport := {'Root Portfolio'. ' Balance = 0 pesos'} asOrderedCollection.
	
	self assert: expectedReport equals: aDetailedTreePrinter report.
	
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/16/2022 14:06:00'!
test18DetailedTreePrinterOfAPortfolioWithAReceptiveAccountWithoutTransactionsIndicatesExpectedReport
	| aRootPortfolio aReceptiveAccount aDetailedTreePrinter expectedReport |
	
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	
	aRootPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount.
	aDetailedTreePrinter := PortfolioDetailedTreePrinter of: aRootPortfolio.
	
	expectedReport := {'Root Portfolio'. ' Rocio'. '  Balance = 0 pesos'. ' Balance = 0 pesos'} asOrderedCollection.
	
	self assert: expectedReport equals: aDetailedTreePrinter report.
	
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/16/2022 14:05:56'!
test19DetailedTreePrinterOfAPortfolioWithAReceptiveAccountWithATransactionIndicatesExpectedReport
	| aRootPortfolio aReceptiveAccount aDetailedTreePrinter expectedReport |
	
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	Deposit register: 100*peso on: aReceptiveAccount.
	
	aRootPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount.
	aDetailedTreePrinter := PortfolioDetailedTreePrinter of: aRootPortfolio.
	
	expectedReport := {'Root Portfolio'. ' Rocio'. '  Deposito por 100 pesos'. '  Balance = 100 pesos'. ' Balance = 100 pesos'} asOrderedCollection.
	
	self assert: expectedReport equals: aDetailedTreePrinter report.
	
	! !

!ReportTest methodsFor: 'test' stamp: 'mr 6/16/2022 14:05:49'!
test20DetaliedTreePrinterOfAPortfolioWithManyAccountsIndicatesExpectedReport
	| aReceptiveAccount aSecondReceptiveAccount aThirdReceptiveAccount aRootPortfolio aChildPortfolio aDetailedTreePrinter expectedReport |
	aReceptiveAccount := ReceptiveAccount named: 'Rocio'.
	Deposit register: 100*peso on: aReceptiveAccount.
	Withdraw register: 20*peso on: aReceptiveAccount.
	
	aSecondReceptiveAccount := ReceptiveAccount named: 'Martin'.
	Deposit register: 50*peso on: aSecondReceptiveAccount.
	Withdraw register: 40*peso on: aSecondReceptiveAccount.
	
	aThirdReceptiveAccount := ReceptiveAccount named: 'Juan'.
	Deposit register: 100*peso on: aThirdReceptiveAccount.
	
	aChildPortfolio := Portfolio named: 'Child Portfolio' with: aSecondReceptiveAccount with: aThirdReceptiveAccount .
	aRootPortfolio := Portfolio named: 'Root Portfolio' with: aReceptiveAccount with: aChildPortfolio.
	
	aDetailedTreePrinter := PortfolioDetailedTreePrinter of: aRootPortfolio.
	expectedReport := {'Root Portfolio'. ' Rocio'. '  Deposito por 100 pesos'. '  Extraccion por 20 pesos'. '  Balance = 80 pesos'. ' Child Portfolio'. '  Martin'. '   Deposito por 50 pesos'. '   Extraccion por 40 pesos'. '   Balance = 10 pesos'. '  Juan'. '   Deposito por 100 pesos'. '   Balance = 100 pesos'. '  Balance = 110 pesos'. ' Balance = 190 pesos'} asOrderedCollection. 
	self assert: expectedReport equals: aDetailedTreePrinter report.
	
	! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'mr 6/15/2022 23:13:16'!
accept: aReport
	self subclassResponsibility! !

!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'mr 6/12/2022 20:53:46'!
name
	^name! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'mr 6/15/2022 23:23:17'!
accept: aReport
	aReport visitAPortfolio: self.! !

!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'private' stamp: 'mr 6/12/2022 22:29:47'!
initializeNamed: aName
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'private' stamp: 'mr 6/12/2022 23:52:12'!
iterateAccounts: anAction
	accounts do: anAction! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/12/2022 22:24:00'!
named: aPortfolioName
	^self new initializeNamed: aPortfolioName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/12/2022 21:49:28'!
named: aPortfolioName with: anAccount
	^self new
		initializeNamed: aPortfolioName;
		add: anAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/12/2022 22:27:00'!
named: aPortfolioName with: anAccount with: anotherAccount
	^self new
		initializeNamed: aPortfolioName;
		add: anAccount;
		add: anotherAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'mr 6/12/2022 21:50:06'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'mr 6/12/2022 21:51:23'!
initializeWith: aReceptiveAccountName
	name := aReceptiveAccountName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'rp 6/11/2022 19:03:21'!
balance

	^transactions 
		inject: 0*peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'mr 6/12/2022 20:54:51'!
name
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'mr 6/15/2022 23:23:32'!
accept: aReport
	aReport visitAReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'mr 6/12/2022 20:54:26'!
named: aReceptiveAccountName
	^self new initializeWith: aReceptiveAccountName! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'mr 6/15/2022 23:13:17'!
accept: aReport
	self subclassResponsibility.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'private' stamp: 'mr 6/15/2022 23:22:24'!
accept: aReport
	^aReport visitADeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'private' stamp: 'mr 6/15/2022 23:13:18'!
accept: aReport
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'private' stamp: 'mr 6/15/2022 23:22:38'!
accept: aReport
	^aReport visitATransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'private' stamp: 'mr 6/15/2022 23:22:50'!
accept: aReport
	^aReport visitATransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'private' stamp: 'mr 6/15/2022 23:23:01'!
accept: aReport
	^aReport visitAWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:01'!
initializeWith: anAccount
	self subclassResponsibility! !

!Report methodsFor: 'as yet unclassified' stamp: 'rp 6/11/2022 16:45:04'!
report
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:22'!
visitADeposit: aDeposit
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:37'!
visitATransferDepositLeg: aTransferDepositLeg
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:48'!
visitATransferWithdrawLeg: aTransferWithdrawLeg
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:00'!
visitAWithdraw: aWithdraw
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'rp 6/11/2022 16:46:36'!
of: anAccount
	^self new initializeWith: anAccount! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:20:19'!
addTransactions

	(account transactions) do: [:aTransaction | 
		report add: (aTransaction accept: self)].
	
	report add: 'Balance = ', (account balance amount) asString, ' pesos'.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:17:23'!
initializeWith: anAccount
	account := anAccount.
	report := OrderedCollection new.
	self addTransactions.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:20:02'!
report
	^report! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:23'!
visitADeposit: aDeposit
	^'Deposito por ' ,(aDeposit value amount) asString , ' pesos' ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:37'!
visitATransferDepositLeg: aTransferDepositLeg
	^'Entrada por transferencia de ' ,(aTransferDepositLeg value amount) asString , ' pesos'! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:49'!
visitATransferWithdrawLeg: aTransferWithdrawLeg
	^'Salida por transferencia de ' ,(aTransferWithdrawLeg value amount) asString , ' pesos'! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:00'!
visitAWithdraw: aWithdraw
	^'Extraccion por ' ,(aWithdraw value amount) asString , ' pesos'! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'rp 6/11/2022 16:47:25'!
initializeWith: anAccount
	account := anAccount.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:13:19'!
report
	
	^(account transactions) sum: [:aTransaction | aTransaction accept: self ]
		ifEmpty: [0 * peso]
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:23'!
visitADeposit: aDeposit
	^0 * peso.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:38'!
visitATransferDepositLeg: aTransferDepositLeg
	^aTransferDepositLeg affectBalance: 0 * peso.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:22:49'!
visitATransferWithdrawLeg: aTransferWithdrawLeg
	^aTransferWithdrawLeg affectBalance: 0 * peso.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:00'!
visitAWithdraw: aWithdraw
	^0 * peso.! !


!classDefinition: #TreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TreePrinter
	instanceVariableNames: 'indentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:06:57'!
decreaseIndentationLevelBy: aNumberOfSpaces
	indentationLevel := indentationLevel - aNumberOfSpaces .! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:07:36'!
increaseIndentationLevelBy: aNumberOfSpaces
	indentationLevel := indentationLevel + aNumberOfSpaces .! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:07:46'!
initializeWith: anAccount
	account := anAccount.
	report := OrderedCollection new.
	indentationLevel := 0.! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:17'!
report
	self visitAPortfolio: account.
	^report.! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:07:52'!
tab: anAccountName
	| spacesConcat |
	spacesConcat := ''.

	indentationLevel timesRepeat: [spacesConcat := ' ', spacesConcat ].
	^spacesConcat, anAccountName.! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:16'!
visitAPortfolio: aPortfolio
	self subclassResponsibility.! !

!TreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/15/2022 23:23:31'!
visitAReceptiveAccount: aReceptiveAccount
	self subclassResponsibility.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
TreePrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:08:14'!
addTransactionsOf: aReceptiveAccount
	| accountSummary |
	accountSummary := AccountSummary of: aReceptiveAccount.
	
	(accountSummary report) do: [:eachTransaction |
		self increaseIndentationLevelBy: 1.
		report add: (self tab: eachTransaction).
		self decreaseIndentationLevelBy: 1.
	].
	
! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:08:49'!
visitAPortfolio: aPortfolio
	report add: (self tab: aPortfolio name).
	
	aPortfolio iterateAccounts: [:eachAccount | 
		self increaseIndentationLevelBy: 1.
		eachAccount accept: self.
	].

	self increaseIndentationLevelBy: 1.
	report add: 	(self tab: 'Balance = ', (aPortfolio balance amount) asString, ' pesos').
	self decreaseIndentationLevelBy: 2.! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:08:56'!
visitAReceptiveAccount: aReceptiveAccount
	
	report add: (self tab: aReceptiveAccount name).
	
	self addTransactionsOf: aReceptiveAccount.

	self decreaseIndentationLevelBy: 1.
! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
TreePrinter subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:09:22'!
visitAPortfolio: aPortfolio
	report add: (self tab: aPortfolio name).
	
	aPortfolio iterateAccounts: [:eachAccount | 
		self increaseIndentationLevelBy: 1.
		eachAccount accept: self
	].
! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'mr 6/16/2022 14:09:29'!
visitAReceptiveAccount: aReceptiveAccount
	report add: (self tab: aReceptiveAccount name).
	self decreaseIndentationLevelBy: 1.
! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
