// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {NudgeCampaign} from "../campaign/NudgeCampaign.sol";
import {NudgeCampaignFactory} from "../campaign/NudgeCampaignFactory.sol";
import {TestERC20} from "../mocks/TestERC20.sol";

contract UltimateClaimAttackTest is Test {
    NudgeCampaign private campaign;
    NudgeCampaignFactory private factory;
    TestERC20 private token;
    TestERC20 private rewardToken;
    
    address private campaignAdmin = address(1);
    address private swapCaller = address(2);
    address private treasury = address(3);
    address private attacker = address(4);
    address private victim = address(5);
    uint32 private holdingPeriod = 7 days;
    uint256 private constant REWARD_PPQ = 2e13;
    uint256 private RANDOM_UUID = 123456789;
    uint256 private VICTIM_UUID = 987654321; // Victim's participation ID
    uint256 private constant INITIAL_FUNDING = 1_000_000e18;

    function setUp() public {
        token = new TestERC20("DepositToken", "DT");
        rewardToken = new TestERC20("RewardToken", "RT");

        // Deploy the campaign factory
        factory = new NudgeCampaignFactory(treasury, campaignAdmin, campaignAdmin, swapCaller);

        // Deploy a campaign using the factory
        address campaignAddress = factory.deployCampaign(
            holdingPeriod,
            address(token),
            address(rewardToken),
            REWARD_PPQ,
            campaignAdmin,
            0,
            treasury,
            RANDOM_UUID
        );

        campaign = NudgeCampaign(payable(campaignAddress));

        // Fund the campaign with reward tokens
        vm.store(
            address(rewardToken),
            keccak256(abi.encode(campaignAdmin, uint256(0))), // ERC-20 balance storage slot
            bytes32(uint256(INITIAL_FUNDING))
        );

        vm.prank(campaignAdmin);
        rewardToken.transfer(address(campaign), INITIAL_FUNDING);

        // Give victim some rewards to claim
        vm.store(
            address(rewardToken),
            keccak256(abi.encode(victim, uint256(0))), 
            bytes32(uint256(500e18)) // Victim has 500 tokens
        );
    }

    function test_UltimateClaimAttack() public {
        console.log("Starting Ultimate Claim Attack");

        // Step 1: Fake pIDs (Shadow Clone Attack)
        uint256[] memory fakePIDs = new uint256[](3);
        fakePIDs[0] = RANDOM_UUID + 1;
        fakePIDs[1] = RANDOM_UUID + 2;
        fakePIDs[2] = RANDOM_UUID + 3;

        console.log("Attempting to claim fake participations...");

        vm.prank(attacker);
        try campaign.claimRewards(fakePIDs) {
            console.log("Exploit Success: Fake participations accepted");
        } catch {
            console.log("Exploit Failed: Fake participations were rejected");
        }

        // Step 2: Time Warp (Time Travel Attack)
        console.log("Fast-forwarding blockchain time...");
        vm.warp(block.timestamp + holdingPeriod - 1);

        uint256[] memory pIDs = new uint256[](1);
        pIDs[0] = RANDOM_UUID;

        vm.prank(attacker);
        try campaign.claimRewards(pIDs) {
            console.log("Exploit Success: Time bypass successful");
        } catch {
            console.log("Exploit Failed: Holding period enforcement is working");
        }

        // Step 3: Gas War Heist (Front-Running Victims)
        console.log("Trying to front-run victim...");

        uint256[] memory victimPIDs = new uint256[](1);
        victimPIDs[0] = VICTIM_UUID;

        vm.prank(attacker);
        try campaign.claimRewards(victimPIDs) {
            console.log("Exploit Success: Front-ran victim and stole their rewards");
        } catch {
            console.log("Exploit Failed: Contract prevents front-running");
        }

        console.log("Attack Completed");
    }
}