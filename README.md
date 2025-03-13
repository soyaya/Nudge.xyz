# Nudge.xyz audit details
- Total Prize Pool: $20,000 in USDC
  - HM awards: up to $17,000 USDC
    - If no valid Highs or Mediums are found, the HM pool is $0 
  - Judge awards: $1,500 in USDC
  - Validator awards: $1,000 USDC
  - Scout awards: $500 in USDC
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts March 17, 2025 20:00 UTC
- Ends March 24, 2025 20:00 UTC

*There are no QA awards for this audit.*

**Note re: risk level upgrades/downgrades**

Two important notes about judging phase risk adjustments: 
- High- or Medium-risk submissions downgraded to Low-risk (QA) will be ineligible for awards.
- Upgrading a Low-risk finding from a QA report to a Medium- or High-risk finding is not supported.

As such, wardens are encouraged to select the appropriate risk level carefully during the submission phase.

## Automated Findings / Publicly Known Issues

The 4naly3er report can be found [here](https://github.com/code-423n4/2025-03-nudgexyz/blob/main/4naly3er-report.md).

_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a publicly known issue and is ineligible for awards._

- Any issue already mentioned in the first audit of our smart contracts and that we acknowledged.
- No time-lock for admin functions or role management.

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

# Overview

[ ⭐️ SPONSORS: add additional info here]

### Setup:
- pnpm install
- forge install openzeppelin/openzeppelin-contracts

### Running Tests:
- forge test

### Audits
[Oak Security Audit Report](https://github.com/oak-security/audit-reports/blob/main/Nudge/2025-03-07%20Audit%20Report%20-%20Nudge%20Campaigns.pdf) - Published on March 7, 2025

Since the Oak Security Audit was completed, we have made the following 2 changes:

1. We added a function to rescue tokens (function rescueTokens(address token)). Without this function, if someone were to send tokens (other than the reward tokens) to a campaign contract, they would become stuck and therefore lost: Commit [23a8098f84d1100baee349be0f33344b68dccf2a](https://github.com/violetprotocol/nudge-smart-contracts/commit/23a8098f84d1100baee349be0f33344b68dccf2a).

2. We changed the logic for campaigns where the campaign admin does not want them to start immediately upon deployment. In this case, the address with the NUDGE_ADMIN_ROLE had to call setIsCampaignActive() to activate the campaign once the startTimestamp was reached. With the change introduced by Commit [e0fe46913140110ba6c1fa68a63c7a41a6dd4db2](https://github.com/violetprotocol/nudge-smart-contracts/commit/e0fe46913140110ba6c1fa68a63c7a41a6dd4db2), the campaign will automatically be turned "active" once the startTimestamp is reached by a call to handleReallocation(). Importantly, a campaign can still be set to active or inactive manually.

## Links

- **Previous audits:** [Oak Security Audit Report](https://github.com/oak-security/audit-reports/blob/main/Nudge/2025-03-07%20Audit%20Report%20-%20Nudge%20Campaigns.pdf)
  - ✅ SCOUTS: If there are multiple report links, please format them in a list.
- **Documentation:** https://docs.nudge.xyz, with the most relevant section for the audit being https://docs.nudge.xyz/technical-documentation/smart-contracts
- **Website:** https://nudge.xyz/
- **X/Twitter:** https://x.com/nudgexyz

---

# Scope

[ ✅ SCOUTS: add scoping and technical details here ]

### Files in scope
- ✅ This should be completed using the `metrics.md` file
- ✅ Last row of the table should be Total: SLOC
- ✅ SCOUTS: Have the sponsor review and and confirm in text the details in the section titled "Scoping Q amp; A"

*For sponsors that don't use the scoping tool: list all files in scope in the table below (along with hyperlinks) -- and feel free to add notes to emphasize areas of focus.*

| Contract | SLOC | Purpose | Libraries used |  
| ----------- | ----------- | ----------- | ----------- |
| [contracts/folder/sample.sol](https://github.com/code-423n4/repo-name/blob/contracts/folder/sample.sol) | 123 | This contract does XYZ | [`@openzeppelin/*`](https://openzeppelin.com/contracts/) |

### Files out of scope
✅ SCOUTS: List files/directories out of scope

## Scoping Q &amp; A

### General questions
### Are there any ERC20's in scope?: Yes

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".

Any (all possible ERC20s)


### Are there any ERC777's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



### Are there any ERC721's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



### Are there any ERC1155's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



✅ SCOUTS: Once done populating the table below, please remove all the Q/A data above.

| Question                                | Answer                       |
| --------------------------------------- | ---------------------------- |
| ERC20 used by the protocol              |       🖊️             |
| Test coverage                           | ✅ SCOUTS: Please populate this after running the test coverage command                          |
| ERC721 used  by the protocol            |            🖊️              |
| ERC777 used by the protocol             |           🖊️                |
| ERC1155 used by the protocol            |              🖊️            |
| Chains the protocol will be deployed on | Ethereum |

### ERC20 token behaviors in scope

| Question                                                                                                                                                   | Answer |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| [Missing return values](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#missing-return-values)                                                      |   Out of scope  |
| [Fee on transfer](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#fee-on-transfer)                                                                  |  Out of scope  |
| [Balance changes outside of transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#balance-modifications-outside-of-transfers-rebasingairdrops) | Out of scope    |
| [Upgradeability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#upgradable-tokens)                                                                 |   Out of scope  |
| [Flash minting](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#flash-mintable-tokens)                                                              | Out of scope    |
| [Pausability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#pausable-tokens)                                                                      | Out of scope    |
| [Approval race protections](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#approval-race-protections)                                              | In scope    |
| [Revert on approval to zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-approval-to-zero-address)                            | In scope    |
| [Revert on zero value approvals](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-approvals)                                    | In scope    |
| [Revert on zero value transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                    | In scope    |
| [Revert on transfer to the zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-transfer-to-the-zero-address)                    | In scope    |
| [Revert on large approvals and/or transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-large-approvals--transfers)                  | In scope    |
| [Doesn't revert on failure](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#no-revert-on-failure)                                                   |  In scope   |
| [Multiple token addresses](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                          | Out of scope    |
| [Low decimals ( < 6)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#low-decimals)                                                                 |   In scope  |
| [High decimals ( > 18)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#high-decimals)                                                              | Out of scope    |
| [Blocklists](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#tokens-with-blocklists)                                                                | Out of scope    |

### External integrations (e.g., Uniswap) behavior in scope:


| Question                                                  | Answer |
| --------------------------------------------------------- | ------ |
| Enabling/disabling fees (e.g. Blur disables/enables fees) | No   |
| Pausability (e.g. Uniswap pool gets paused)               |  No   |
| Upgradeability (e.g. Uniswap gets upgraded)               |   No  |


### EIP compliance checklist
N/A

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Question                                | Answer                       |
| --------------------------------------- | ---------------------------- |
| src/Token.sol                           | ERC20, ERC721                |
| src/NFT.sol                             | ERC721                       |


# Additional context

## Main invariants

### Solvency Invariants

1. Token Balance Integrity
- `rewardToken.balanceOf(campaign) >= pendingRewards + accumulatedFees`
- *Ensures the contract always maintains sufficient reward tokens to cover all pending rewards and accumulated fees.*
1. Protocol Solvency
- For any active participation p:`p.rewardAmount <= rewardToken.balanceOf(campaign) - (pendingRewards - p.rewardAmount) - accumulatedFees`
- *Guarantees that any individual user's reward can be fully covered by the contract's current token balance, after accounting for fees*

### State Consistency Invariants

1. Participation State Consistency
- State transitions only occur from `PARTICIPATING` → `CLAIMED` or `PARTICIPATING` → `INVALIDATED`
- Once in `CLAIMED` or `INVALIDATED` state, a participation cannot change state
1. Participation Tracking Consistency
- `sum(participations[i].toAmount for all i from 1 to pID) == totalReallocatedAmount` *Ensures the sum of all participation amounts matches the tracked total reallocated amount*
- pendingRewards == sum of all participation.rewardAmount where participation.status == PARTICIPATING
The pendingRewards value must equal the sum of reward amounts for all participations in the PARTICIPATING state.
- distributedRewards == sum of all participations.rewardAmount where participation.status == CLAIMED
    
    The distributedRewards value must equal the sum of reward amounts for all participations in the CLAIMED state.
    

### Claiming Rules Invariants

1. Claim Conditions
- User can only claim rewards for their own participations
- User can only claim rewards after holdingPeriodInSeconds has elapsed
- User can only claim rewards for participations in PARTICIPATING state
- User can only claim rewards for a participation once

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Attack ideas (where to focus for bugs)
We’ll call any type of user of the protocol, a “user” (campaign administrators, end users a.k.a campaign participants, the Nudge team…), collectively referred as “users”.

Here are our main concerns in order from most critical to less critical:

- Loss of funds by any user.
- Accounting and calculation logic: a user receives significantly less, or more, tokens than they should.
- A campaign participant is able to claim rewards without fulfilling the conditions of the campaign. For example, claiming rewards before the end of the holding period.
- Loss of access and permissions granted to the Nudge team.
- Loss of access and permissions granted to the campaign administrator.
- A malicious actor gaining control to a functionality they shouldn’t have access to.
- Service halting (e.g denial of service attacks), rendering critical functionalities of the protocol unusable by users.

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## All trusted roles in the protocol

We are using role-based access control in the protocol. Below are the roles that can be found, and how they will  be assigned initially:

- NUDGE_ADMIN_ROLE: This role is given to a multisig (Safe) wallet controlled by Nudge.
- DEFAULT_ADMIN_ROLE: Similar to NUDGE_ADMIN_ROLE, initially.
- NUDGE_OPERATOR_ROLE: This role is given to one of our Relayers, submitting transactions programatically.
- SWAP_CALLER_ROLE: This role is initially given to one of Li.fi’s contracts (called Executor).
- CAMPAIGN_ADMIN_ROLE: This role is given to the administrator of a campaign. It is campaign-specific.

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Role                                | Description                       |
| --------------------------------------- | ---------------------------- |
| Owner                          | Has superpowers                |
| Administrator                             | Can change fees                       |

## Describe any novel or unique curve logic or mathematical models implemented in the contracts:

N/A

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Running tests

forge build
forge test --gas-report

Note: Because we have fuzzy tests, running all the tests can take several minutes to complete.

✅ SCOUTS: Please format the response above 👆 using the template below👇

```bash
git clone https://github.com/code-423n4/2023-08-arbitrum
git submodule update --init --recursive
cd governance
foundryup
make install
make build
make sc-election-test
```
To run code coverage
```bash
make coverage
```
To run gas benchmarks
```bash
make gas
```

✅ SCOUTS: Add a screenshot of your terminal showing the gas report

✅ SCOUTS: Add a screenshot of your terminal showing the test coverage

## Miscellaneous
Employees of Nudge and employees' family members are ineligible to participate in this audit.

Code4rena's rules cannot be overridden by the contents of this README. In case of doubt, please check with C4 staff.


# Scope

*See [scope.txt](https://github.com/code-423n4/2025-03-nudgexyz/blob/main/scope.txt)*

### Files in scope


| File   | Logic Contracts | Interfaces | nSLOC | Purpose | Libraries used |
| ------ | --------------- | ---------- | ----- | -----   | ------------ |
| /src/campaign/NudgeCampaign.sol | 1| **** | 272 | |@openzeppelin/contracts/token/ERC20/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/access/AccessControl.sol<br>@openzeppelin/contracts/utils/math/Math.sol<br>@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol|
| /src/campaign/NudgeCampaignFactory.sol | 1| **** | 164 | |@openzeppelin/contracts/access/AccessControl.sol<br>@openzeppelin/contracts/token/ERC20/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/utils/Create2.sol|
| /src/campaign/NudgePointsCampaigns.sol | 1| **** | 129 | |@openzeppelin/contracts/token/ERC20/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/access/AccessControl.sol<br>@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol|
| /src/campaign/interfaces/IBaseNudgeCampaign.sol | ****| 1 | 31 | ||
| /src/campaign/interfaces/INudgeCampaign.sol | ****| 1 | 22 | ||
| /src/campaign/interfaces/INudgeCampaignFactory.sol | ****| 1 | 4 | |@openzeppelin/contracts/access/IAccessControl.sol|
| /src/campaign/interfaces/INudgePointsCampaign.sol | ****| 1 | 19 | ||
| **Totals** | **3** | **4** | **641** | | |

### Files out of scope

*See [out_of_scope.txt](https://github.com/code-423n4/2025-03-nudgexyz/blob/main/out_of_scope.txt)*

| File         |
| ------------ |
| ./src/mocks/MockTokenDecimals.sol |
| ./src/mocks/TestERC20.sol |
| ./src/mocks/TestUSDC.sol |
| ./src/test/NudgeCampaign.t.sol |
| ./src/test/NudgeCampaignAdmin.t.sol |
| ./src/test/NudgeCampaignFactory.t.sol |
| ./src/test/NudgeCampaignReallocation.t.sol |
| ./src/test/NudgePointsCampaigns.t.sol |
| ./src/test/NudgePointsCampaignsHandleReallocationTest.t.sol |
| Totals: 9 |

