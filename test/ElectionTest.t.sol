// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";

import "forge-std/console.sol";
import "../src/Elections.sol";

contract ElectionTest is Test {
    address owner;
    Election election;
    function setUp() public {
        owner = vm.addr(1);
        vm.startPrank(owner);
        vm.deal(owner, 1 ether);
        election = new Election();
        vm.stopPrank();
    }
    function testCreateElection() public {
        vm.startPrank(owner);
        string memory name = "Presidential Election";
        string memory description = "This is a test election";
        uint256 startTime = block.timestamp;
        uint256 endTime = block.timestamp + 1 days;
        string[] memory candidateNames = new string[](2);
        candidateNames[0] = "Fufufafa";
        candidateNames[1] = "Mulyono";

        string[] memory candidateParties = new string[](2);
        candidateParties[0] = "Partai Merah";
        candidateParties[1] = "Partai Biru";
        uint256 electionId = election.createElection(
            name,
            description,
            startTime,
            endTime,
            candidateNames,
            candidateParties
        );

        (
            string memory nameReturned,
            string memory descriptionReturned,
            uint256 startTimeReturned,
            uint256 endTimeReturned,
            Election.Candidate[] memory candidatesReturned
        ) = election.getElection(electionId);
        vm.stopPrank();
        assertEq(nameReturned, name);
        assertEq(descriptionReturned, description);
        assertEq(startTimeReturned, startTime);
        assertEq(endTimeReturned, endTime);
        assertEq(candidatesReturned.length, 2);
        assertEq(candidatesReturned[0].name, candidateNames[0]);
        assertEq(candidatesReturned[0].party, candidateParties[0]);
        assertEq(candidatesReturned[1].name, candidateNames[1]);
        assertEq(candidatesReturned[1].party, candidateParties[1]);
        assertEq(candidatesReturned[0].voteCount, 0);
        assertEq(candidatesReturned[1].voteCount, 0);
        assertEq(election.electionId(), 1);
    }
    function testVoteSuccessfully() public {
        
        address voter = vm.addr(2);
        vm.startPrank(owner);
        string memory name = "Test Election";
        string memory description = "Description";
        uint256 startTime = block.timestamp;
        uint256 endTime = block.timestamp + 1 days;

        string[] memory candidateNames = new string[](2);
        candidateNames[0] = "Alice";
        candidateNames[1] = "Bob";

        string[] memory candidateParties = new string[](2);
        candidateParties[0] = "Party A";
        candidateParties[1] = "Party B";

        uint256 id = election.createElection(
            name,
            description,
            startTime,
            endTime,
            candidateNames,
            candidateParties
        );
        vm.stopPrank();

        
        vm.startPrank(voter);
        election.vote(id, "Alice");
        vm.stopPrank();

        
        Election.Candidate[] memory candidates = election.getAllCandidates(id);
        assertEq(candidates[0].name, "Alice");
        assertEq(candidates[0].voteCount, 1);
        assertEq(candidates[1].voteCount, 0);
    }
}
   