// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Election {
    struct Candidate {
        string name;
        string party;
        uint256 voteCount;
    }
    struct ElectionType {
        string name;
        string description;
        uint256 startTime;
        uint256 endTime;
        Candidate[] candidates;
        mapping(address => bool) hasVoted;
    }


    event ElectionCreated(
        uint256 indexed electionId,
        string name,
        string description,
        uint256 startTime,
        uint256 endTime
    );
    event VotedSuccesfully(
        address indexed voter,
        uint256 indexed electionId,
        string candidateName
    );
    error NotOwner();
    error LengthMismatch();
    error ElectionNotActive();
    error AlreadyVoted();
    mapping(uint256 => ElectionType) public elections;
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }
    uint256 public electionId;
    address public owner;
    constructor() {
        owner = msg.sender;
        electionId = 0;
    }
    function createElection(
        string memory name,
        string memory description,
        uint256 startTime,
        uint256 endTime,
        string[] memory candidateNames,
        string[] memory candidateParties
    ) external onlyOwner returns (uint256) {
        if (candidateNames.length != candidateParties.length) {
            revert LengthMismatch();
        }
        ElectionType storage newElection = elections[electionId];
        newElection.name = name;
        newElection.description = description;
        newElection.startTime = startTime;
        newElection.endTime = endTime;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            newElection.candidates.push(Candidate({
                name: candidateNames[i],
                party: candidateParties[i],
                voteCount: 0
            }));
        }
        electionId++;
        emit ElectionCreated(
            electionId - 1,
            name,
            description,
            startTime,
            endTime
        );
        return electionId - 1;

    }


    function vote(uint256 _electionId, string memory candidateName) external {
        
        if(block.timestamp<elections[_electionId].startTime || block.timestamp>elections[_electionId].endTime){
            revert ElectionNotActive();
        }
        if(elections[_electionId].hasVoted[msg.sender]){
            revert AlreadyVoted();
        }

        elections[_electionId].hasVoted[msg.sender] = true;
        
        for(uint256 i=0; i<elections[_electionId].candidates.length; i++){
            
            if(keccak256(abi.encodePacked(elections[_electionId].candidates[i].name)) == keccak256(abi.encodePacked(candidateName))){
                elections[_electionId].candidates[i].voteCount++;
                emit VotedSuccesfully(msg.sender, _electionId, candidateName);
                break;
            }
        }



    }
    function getElectionResult(uint256 _electionId) external view returns (string memory) {
        
        Candidate[] memory candidates = elections[_electionId].candidates;
        uint256 highestVoteCount = 0;
        string memory winner;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > highestVoteCount) {
                highestVoteCount = candidates[i].voteCount;
                winner = candidates[i].name;
            }
        }
        
        return winner;
    }
    function getElection(uint256 _electionId) external view returns (string memory name,
        string memory description,
        uint256 startTime,
        uint256 endTime,
        Candidate[] memory candidates) {
        ElectionType storage election = elections[_electionId];
        name = election.name;
        description = election.description;
        startTime = election.startTime;
        endTime = election.endTime;
        candidates = election.candidates;
        return (name, description, startTime, endTime, candidates);
        
    }
    function getAllCandidates(uint256 _electionId) external view returns (Candidate[] memory) {
        return elections[_electionId].candidates;
    }
}