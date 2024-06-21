## Unusual Permit Function

Certain tokens like DAI, RAI, GLM, STAKE, CHAI, HAKKA, USDFL, and HNY have implemented a permit() function that diverges from the EIP2612 standard. This deviation means that the function may not revert as expected in critical scenarios, potentially allowing unintended execution to proceed in subsequent code lines. For a more consistent and compatible alternative, consider using Uniswap's Permit2 implementation, which offers enhanced integration and reliability across various platforms and protocols.

## Revert on Large Approvals & Transfers

Some tokens (e.g. UNI, COMP) revert if the value passed to approve or transfer is larger than uint96.

Both of the above tokens have special case logic in approve that sets allowance to type(uint96).max if the approval amount is uint256(-1), which may cause issues with systems that expect the value passed to approve to be reflected in the allowances mapping.

## No Revert on Failure

Some tokens do not revert on failure, but instead return false (e.g. ZRX, EURS).

While this is technically compliant with the ERC20 standard, it goes against common solidity coding practices and may be overlooked by developers who forget to wrap their calls to transfer in a require.

## Revert on Transfer to the Zero Address

Some tokens (e.g. openzeppelin) revert when attempting to transfer to address(0).

This may break systems that expect to be able to burn tokens by transferring them to address(0).

## Non string metadata

Some tokens (e.g. MKR) have metadata fields (name / symbol) encoded as bytes32 instead of the string prescribed by the ERC20 specification.

This may cause issues when trying to consume metadata from these tokens.

## transferFrom with src == msg.sender

Some token implementations (e.g. DSToken) will not attempt to decrease the caller's allowance if the sender is the same as the caller. This gives transferFrom the same semantics as transfer in this case. Other implementations (e.g. OpenZeppelin, Uniswap-v2) will attempt to decrease the caller's allowance from the sender in transferFrom even if the caller and the sender are the same address, giving transfer(dst, amt) and transferFrom(address(this), dst, amt) a different semantics in this case.

examples:

Examples of both semantics are provided:

ERC20.sol: does not attempt to decrease allowance
TransferFromSelf.sol: always attempts to decrease the allowance

## High Decimals

Some tokens have more than 18 decimals (e.g. YAM-V2 has 24).

This may trigger unexpected reverts due to overflow, posing a liveness risk to the contract.

## Low Decimals

Some tokens have low decimals (e.g. USDC has 6). Even more extreme, some tokens like Gemini USD only have 2 decimals.

This may result in larger than expected precision loss.

## Code Injection Via Token Name

Certain malicious tokens have been discovered to embed malicious JavaScript within their name attribute. This exploit enables attackers to potentially extract private keys from users who interact with these tokens through vulnerable frontends. This tactic has been observed in attacks targeting platforms like EtherDelta, illustrating the significant security risks posed by such tokens when used in real-world scenarios.

## Transfer of less than amount

Tokens like cUSDCv3 handle a specific scenario in their transfer functions where amount == type(uint256).max results in transferring only the user's balance. This behavior can pose challenges for systems that transfer a user-provided amount to their contract and subsequently update the user's balance in storage without verifying the actual transferred amount.

This discrepancy may lead to issues where the contract assumes it has transferred a specific amount based on user input, but due to the token's special handling, the actual transfer differs. Such situations can introduce unexpected behaviors or errors in systems that rely on accurate balance updates post-transfer. Therefore, it is essential for systems handling these transfers to carefully validate and confirm the exact amount transferred to maintain consistency and ensure correct contract operations.
