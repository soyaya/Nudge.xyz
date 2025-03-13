# Nudge Campaign Smart Contracts

### Setup:

- `pnpm install`
- `forge install openzeppelin/openzeppelin-contracts`

### Running Tests:

`forge test`

### Audits

- [Oak Security Audit Report](https://github.com/oak-security/audit-reports/blob/main/Nudge/2025-03-07%20Audit%20Report%20-%20Nudge%20Campaigns.pdf) -
  Published on March 7, 2025

Since the Oak Security Audit was completed, we have made the following 2 changes:

1. We added a function to rescue tokens (`function rescueTokens(address token)`). Without this function, if someone were
   to send tokens (other than the reward tokens) to a campaign contract, they would become stuck and therefore lost:
   Commit
   [23a8098f84d1100baee349be0f33344b68dccf2a](https://github.com/violetprotocol/nudge-smart-contracts/commit/23a8098f84d1100baee349be0f33344b68dccf2a).
2. We changed the logic for campaigns where the campaign admin does not want them to start immediately upon deployment.
   In this case, the address with the NUDGE_ADMIN_ROLE had to call setIsCampaignActive() to activate the campaign once
   the startTimestamp was reached. With the change introduced by Commit
   [e0fe46913140110ba6c1fa68a63c7a41a6dd4db2](https://github.com/violetprotocol/nudge-smart-contracts/commit/e0fe46913140110ba6c1fa68a63c7a41a6dd4db2),
   the campaign will automatically be turned "active" once the startTimestamp is reached by a call to
   handleReallocation(). Importantly, a campaign can still be set to active or inactive manually.
