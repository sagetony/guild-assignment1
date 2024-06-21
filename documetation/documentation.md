# Attack Vectors

- [Access Control](#accesscontrol)
- [Bad Randomness]()
- [Code With No Effect]()
- [DOS]()
- [Improper Array Deletion]()
- [Logical Issue]()
- [Overflow/Underflow]()
- [Precision Loss]()
- [Private Data]()
- [Reenterancy Attack]()
- [Tx Authorization]()
- [Unchecked Return Call]()
- [Unsafe Ownership]()

## <font color="yellow"> Access Control<a id="accesscontrol"></a></font>

### Description

- Missed Modifier Validations — It is important to have access control validations on critical functions that execute actions like modifying the owner, transfer of funds and tokens, pausing and unpausing the contracts, etc. Missing validations either in the modifier or inside require or conditional statements will most probably lead to compromise of the contract or loss of funds.
- Incorrect Modifier Names — Due to the developer’s mistakes and spelling errors, it may happen that the name of the modifier or function is incorrect than intended. Malicious actors may also exploit it to call the critical function without the modifier, which may lead to loss of funds or change of ownership depending on the function’s logic.
  -Overpowered Roles — Allowing users to have overpowered roles may lead to vulnerabilities. The practice of least privilege must always be followed in assigning privileges.

### Code Sample

- [Vunerable Contract](#accesscontrol)
- [Test Contract]()

### Recommedation
