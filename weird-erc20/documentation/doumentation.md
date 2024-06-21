## Unusual Permit Function:

**Description:**

Certain tokens like DAI, RAI, GLM, STAKE, CHAI, HAKKA, USDFL, and HNY have a `permit()` function that deviates from the EIP2612 standard. This divergence may lead to unexpected execution in critical scenarios.

It is best to use Uniswap's Permit2 implementation for a more consistent and compatible alternative.

---

## Pausable Tokens:

**Description:**

Tokens with admin-controlled pausing capabilities, such as BNB and ZIL, expose users to risks if the token owner is compromised. Malicious actions could freeze token functionality, impacting users and applications reliant on uninterrupted token transfers.

---

## Tokens with Blocklists:

**Description:**

Tokens like USDC and USDT employ contract-level admin-controlled address blocklists. Abuse of this feature by a malicious token owner can trap funds in a contract, potentially due to regulatory actions or extortion attempts, affecting users and decentralized applications (DApps).

---

## Flash Mintable Tokens:

**Description:**

Tokens like DAI support "flash minting," allowing tokens to be minted and burned within a single transaction. This capability, similar to flash loans, requires careful management to prevent unintended effects on token supply and contract interactions.

---

## Upgradable Tokens:

**Description:**

Some tokens, such as USDC and USDT, are upgradable, enabling owners to modify token logic arbitrarily. Changes in token behavior can disrupt smart contracts reliant on past functionalities, emphasizing the need for precautions to freeze interactions during upgrades.

---

## Balance Modifications Outside of Transfers:

**Description:**
Tokens implementing rebasing (e.g., Ampleforth) or airdrops (e.g., Compound governance tokens) can modify balances outside typical transfer operations. This behavior complicates interactions with smart contracts that cache token balances, potentially leading to operational discrepancies.

---

## Fee on Transfer:

**Description:**
Certain tokens impose transfer fees (e.g., STA, PAXG), impacting transactions in decentralized finance (DeFi) applications. Understanding fee mechanisms is crucial to prevent unexpected losses or disruptions in token transactions.

---

## Reentrant Calls:

**Description:**

Tokens allowing reentrant calls on transfer, such as ERC777 tokens, have been exploited in previous attacks. Mitigating reentrancy risks through secure coding practices is essential to protect token holders and ecosystem integrity.

---

## Missing Return Values:

**Description:**

Tokens like USDT and BNB may lack consistent bool return values in ERC20 methods, affecting contract interactions and integrations. Implementing robust error-handling mechanisms is vital for reliable token operations.

---

## Revert on Large Approvals & Transfers:

**Description:**

Tokens like UNI and COMP revert when values exceed uint96 in approve or transfer functions. Integrating systems must account for special-case logic to manage allowances properly.

---

## No Revert on Failure:

**Description:**

Tokens that return false instead of reverting on failure (e.g., ZRX, EURS) diverge from typical Solidity practices. Developers should ensure proper error handling to avoid unintended consequences in contract interactions.

---

## Revert on Transfer to the Zero Address:

**Description:**

Tokens reverting when attempting to transfer to address(0) can impact contracts expecting to burn tokens. Careful handling of zero-address transfers is crucial to maintain contract functionality.

---

## Non-string Metadata:

**Description:**

Tokens using bytes32 for metadata fields (name/symbol) instead of strings as per ERC20 may encounter compatibility issues. Standardizing metadata handling is essential for seamless token integration.

---

## TransferFrom with src == msg.sender:

**Description:**

Differences in `transferFrom` implementations (e.g., DSToken vs. OpenZeppelin) when src == msg.sender affect allowance management. Consistency in contract behavior ensures predictable token interactions.

---

## High Decimals:

**Description:**

Tokens with high decimals (e.g., YAM-V2 with 24 decimals) may introduce overflow risks in contract operations. Managing token decimals correctly is critical to avoid unintended behavior in smart contracts.

---

## Low Decimals:

**Description:**

Tokens with low decimals (e.g., USDC with 6 decimals) or very low (e.g., Gemini USD with 2 decimals) can impact precision in financial calculations. Adhering to decimal standards minimizes calculation errors.

---

## Revert on Zero Value Transfers:

**Description:**

Tokens reverting on zero-value transfers (e.g., LEND) prevent unintended transactions and protect token functionality from misuse.

---

## Revert on Zero Value Approvals:

**Description:**

Tokens reverting on zero-value approvals (e.g., BNB) require special handling to manage allowances correctly. Integrators should ensure compatibility with such token behaviors.

---

## Revert on Approval To Zero Address:

**Description:**

Tokens reverting on approvals to address(0) (e.g., OpenZeppelin) safeguard against potential misuse. Integrators must accommodate these specific approval behaviors in contract interactions.

---

## Approval Race Protections:

**Description:**

Tokens like USDT and KNC prevent approving an amount M > 0 when an existing amount N > 0 is already approved. This safeguard mitigates potential ERC20 approval race conditions, ensuring secure token operations.

---

## Code Injection Via Token Name:

**Description:**

Malicious tokens embedding JavaScript in their name attribute can exploit vulnerable frontends, risking user security. Instances like those affecting EtherDelta highlight the critical need for robust frontend security measures.

---

## Transfer of less than amount:

**Description:**

Tokens like cUSDCv3 handle specific scenarios where `amount == type(uint256).max` transfers only the user's balance. Integrators must verify transferred amounts to ensure accurate contract interactions and avoid discrepancies.
