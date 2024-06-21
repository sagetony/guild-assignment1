# Attack Vectors

- [Access Control](#accesscontrol)
- [Bad Randomness](#BadRandomness)
- [Code With No Effect](#CodeWithNoEffect)
- [DOS](#DOS)
- [Improper Array Deletion](#ImproperArrayDeletion)
- [Logical Issue](#LogicalIssue)
- [Overflow/Underflow](#OverflowUnderflow)
- [Precision Loss](#PrecisionLoss)
- [Private Data](#PrivateData)
- [Reenterancy Attack](#Reenterancy)
- [Tx Authorization](#TxAuthorization)
- [Unchecked Return Call](#UncheckedReturnCall)
- [Unsafe Ownership](#UnsafeOwnership)
- [Unexpected Ether Balance](#UnexpectedEthBalance)
- [Floating Pragma](#FloatingPragma)
- [Function Default Visibility](#FunctionDefaultVisibility)
- [Outdated Compiler Version](#OutdatedCompilerVersion)
- [Typographical Error](#TypographicalError)
- [Shadowing State Variables](#ShadowingStateVariables)
- [Assert Violation](#AssertViolation)

## <font color="yellow"> Access Control<a id="accesscontrol"></a></font>

### Description

To enhance contract security, it is crucial to implement proper access control validations on critical functions, such as modifying the owner, transferring funds or tokens, and pausing or unpausing contracts. Missing these validations, either in the modifier or within require statements, can lead to unauthorized access and potential loss of funds. Additionally, incorrect modifier names due to developer mistakes or spelling errors can be exploited by malicious actors, allowing them to bypass critical functions without the intended security checks, which may result in unauthorized ownership changes or fund transfers.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/AccessControl.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/AccessControl.t.sol)

### Recommedation

Implement access control like onlyOwner in critical functions.

## <font color="yellow">Bad Randomness<a id="BadRandomness"></a></font>

### Description

Randomness is challenging in Ethereum. Solidity functions and variables that seem unpredictable are often public or influenced by miners. This predictability allows malicious users to replicate and exploit the randomness, compromising the function's reliability.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/BadRandomness.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/BadRandomness.t.sol)

### Recommedation

Don't use blockhash and block.timestamp as source of randomness. Use services like Chainlink VRF to generate Random Numbers.

## <font color="yellow">Code With No Effect<a id="CodeWithNoEffect"></a></font>

### Description

In Solidity, code may not produce the intended effects, and the compiler doesn't warn about effect-free code. This can introduce "dead" code that fails to perform its intended action. For instance, missing trailing parentheses in msg.sender.call.value(address(this).balance)(""); can cause a function to proceed without transferring funds to msg.sender. This can be avoided by checking the return value of the call.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/CodeWithNoEffect.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/CodeWithNoEffect.t.sol)

### Recommedation

It's important to carefully ensure that your contract works as intended. Write unit tests to verify correct behaviour of the code.

## <font color="yellow">DOS<a id="DOS"></a></font>

### Description

Each block has a maximum gas limit, known as the Block Gas Limit, which constrains the total computational effort that can be expended within that block. If the gas spent on a transaction exceeds this limit, the transaction will fail.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/GasLimit.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/BlockLimit.t.sol)

### Recommedation

Caution is advised when you expect to have large arrays that grow over time. Actions that require looping across the entire data structure should be avoided.

## <font color="yellow">Improper Array Deletion<a id="ImproperArrayDeletion"></a></font>

### Description

In Solidity, we remove an element from an array using the “delete” function. However, the length and sequence of the array may not remain as expected. If we delete the array index x, we will see that the array length remains the same, just that the value at index x has been set to zero.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/ImproperArrayDeletion.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/ImproperArrayDeletion.t.sol)

### Recommedation

Instead of “delete” and “.length=0”, use push and pop functions to interact with array elements.

## <font color="yellow">Logical Issues<a id="LogicalIssues"></a></font>

### Description

Common smart contract issues often arise from simple logic errors such as typos or misunderstandings of specifications. These mistakes can severely impact security and functionality. Detecting and resolving these issues requires auditors with deep understanding of the codebase and the contract's intended functionality. This thorough review process is why smart contract audits are time-consuming, expensive, and necessitate experienced auditors.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/LogicalIssue.sol)

- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/LogicalIssue.t.sol)

### Recommedation

Always conduct an audit

## <font color="yellow">Overflow/Underflow<a id="OverflowUnderflow"></a></font>

### Description

An overflow or underflow occurs when an arithmetic operation exceeds the maximum or minimum size of a data type. For example, a uint8 type stores numbers in an 8-bit unsigned format, ranging from 0 to 2^8-1. In computer programming, an integer overflow happens when an arithmetic operation tries to produce a value beyond this range — either larger than the maximum representable value or smaller than the minimum representable value for the given number of bits.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/OverflowUnderflow.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/OverflowUnderflow.t.sol)

### Recommedation

It is recommended to use vetted safe math libraries for arithmetic operations consistently throughout the smart contract system.

## <font color="yellow">Precision Loss<a id="PrecisionLoss"></a></font>

### Description

Smart contracts are high-level programs compiled into EVM bytecode and deployed on the Ethereum blockchain. Solidity arithmetic operations include addition, subtraction, multiplication, division (x / y), modulus (x % y), and exponentiation (x \*\* y). Integer division in Solidity truncates results, so multiplying before dividing helps preserve precision.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/PrecisionLoss.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/PrecisionLoss.t.sol)

### Recommedation

Multiply before divide to avoid loss of precision

## <font color="yellow">Private Data<a id="PrivateData"></a></font>

### Description

It's a common misconception that private variables in Solidity cannot be read. Even if a contract is not publicly accessible, attackers can analyze transaction data to deduce values stored in the contract's state. Therefore, it's crucial not to store unencrypted private data in the contract's code or state to mitigate potential security risks.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/PrivateData.sol)

- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/PrivateData.t.sol)

### Recommedation

Any private data should either be stored off-chain, or carefully encrypted.

## <font color="yellow">Reenterancy<a id="Reenterancy"></a></font>

### Description

Calling external contracts in Solidity poses a significant risk because they can manipulate the control flow. In a reentrancy attack, also known as a recursive call attack, a malicious contract invokes back into the calling contract before the initial function call completes. This can lead to unintended interactions between multiple function invocations, potentially resulting in unexpected and undesirable outcomes. Implementing appropriate safeguards such as using checks-effects-interactions pattern and ensuring proper state management can mitigate these risks.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/ReEntrancy.sol)

- [Attack Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/ReentrancyAttack.sol)

- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/ReEntrancy.t.sol)

### Recommedation

- Make sure all internal state changes are performed before the call is executed. This is known as the Checks-Effects-Interactions pattern
- Use a reentrancy lock (ie. OpenZeppelin's ReentrancyGuard).

## <font color="yellow">Tx Authorization<a id="TxAuthorization"></a></font>

### Description

In Solidity, tx.origin is a global variable that retrieves the address of the original initiator of a transaction. Depending on tx.origin for authorization can pose security risks. This is because a malicious contract called by an authorized account can pass the authorization check by leveraging tx.origin, which returns the address of the initial sender. Consequently, using tx.origin for authorization may inadvertently grant access to unauthorized contracts pretending to be the original sender.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/TxAuthorization.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/TxAuthorization.t.sol)

### Recommedation

tx.origin should not be used for authorization. Use msg.sender instead.

## <font color="yellow">Unchecked Call Return Value<a id="UncheckedCallReturn"></a></font>

### Description

When the return value of a message call is not checked in Solidity, execution continues even if the called contract throws an exception. Accidental call failures or malicious actions forcing failures can lead to unexpected behavior in subsequent program logic, potentially compromising contract functionality and security. Always validate return values to ensure expected program flow and mitigate risks.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/UncheckedReturnCall.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/UncheckedReturnCall.t.sol)

### Recommedation

If you choose to use low-level call methods, make sure to handle the possibility that the call will fail by checking the return value.

## <font color="yellow">Unsafe Ownership<a id="UnsafeOwnership"></a></font>

### Description

Transferring ownership of your contract, e.g. when transferring governance rights or even changing your proxy admin, it’s scary. If you transfer the rights to the wrong account, you are most likely losing the ownership forever.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/UnsafeOwnership.sol)

### Recommedation

Use an ACK method for approve the new owner.

## <font color="yellow">Unexpected Ether balance

<a id="UnexpectedEthBalance"></a></font>

### Description

Contracts can malfunction if they rely strictly on a specific Ether balance assumption. It's possible to forcibly send Ether to a contract without triggering its fallback function, through methods like selfdestruct or by mining to the account. In the worst case, this could lead to denial-of-service (DOS) conditions, potentially rendering the contract unusable.

### Code Sample

- [Vulnerable Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/src/vectorAttack/UnexpectedEthBalance.sol)
- [Test Contract](https://github.com/sagetony/guild-assignment1/blob/dev/vector-attack/test/UnexpectedEthBalance.t.sol)

### Recommedation

Avoid strict equality checks for the Ether balance in a contract.

## <font color="yellow">Floating Pragma

<a id="FloatingPragma"></a></font>

### Description

Deploy contracts using the exact compiler version and flags that were thoroughly tested. Locking the pragma ensures contracts are deployed consistently, preventing potential bugs from outdated compiler versions that could impact the contract system negatively.

### Recommedation

Lock the pragma version and also consider known bugs (https://github.com/ethereum/solidity/releases) for the compiler version that is chosen.

## <font color="yellow">Function Default Visibility

<a id="FunctionDefaultVisibility
"></a></font>

### Description

Functions that do not have a function visibility type specified are public by default. This can lead to a vulnerability if a developer forgot to set the visibility and a malicious user is able to make unauthorized or unintended state changes.

### Recommedation

Functions can be specified as being external, public, internal, or private. It is recommended to make a conscious decision on which visibility type is appropriate for a function. This can dramatically reduce the attack surface of a contract system.

## <font color="yellow">Incorrect interface

<a id="Incorrectinterface
"></a></font>

### Description

A contract interface defines functions with a different type signature than the implementation, causing two different method id's to be created. As a result, when the interfact is called, the fallback method will be executed.

- [Reference](https://github.com/crytic/not-so-smart-contracts/tree/master/incorrect_interface)

### Recommedation

Verify that type signatures are identical between inferfaces and implementations.

## <font color="yellow">Outdated Compiler Version

<a id="OutdatedCompilerVersion
"></a></font>

### Description

Using an outdated compiler version can be problematic especially if there are publicly disclosed bugs and issues that affect the current compiler version.

- [Reference](https://swcregistry.io/docs/SWC-102)

### Recommedation

It is recommended to use a recent version of the Solidity compiler.

## <font color="yellow">Typographical Error<a id="TypographicalError"></a></font>

### Description

Typographical errors can occur in Solidity, such as intending to add a number to a variable using += but accidentally writing =+. This typo results in a valid but incorrect operation, reinitializing the variable instead of summing it.

- [Reference](https://swcregistry.io/docs/SWC-129)

### Recommedation

The weakness can be avoided by performing pre-condition checks on any math operation or using a vetted library for arithmetic calculations such as SafeMath developed by OpenZeppelin.

## <font color="yellow">Shadowing State Variables

<a id="ShadowingStateVariables"></a></font>

### Description

Solidity allows ambiguous naming of state variables with inheritance. For example, if Contract A and Contract B both define a variable x, and A inherits B, there will be two separate x variables. This can result in Contract A accessing one version of x and Contract B accessing another. In complex systems, this ambiguity can go unnoticed and cause security issues.

- [Reference](https://swcregistry.io/docs/SWC-119)

### Recommedation

Review storage variable layouts for your contract systems carefully and remove any ambiguities. Always check for compiler warnings as they can flag the issue within a single contract.

## <font color="yellow">Assert Violation<a id="AssertViolation"></a></font>

### Description

The Solidity assert() function checks for conditions that should always be true. If assert fails, it indicates a serious error: either a contract bug causing an invalid state or misuse of assert for input validation.

- [Reference](https://swcregistry.io/docs/SWC-110)

### Recommedation

Consider whether the condition checked in the assert() is actually an invariant. If not, replace the assert() statement with a require() statement.
If the exception is indeed caused by unexpected behaviour of the code, fix the underlying bug(s) that allow the assertion to be violated.
