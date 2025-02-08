// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProposalContract {
    struct Proposal {
        string title;
        string description;
        uint256 approve;
        uint256 reject;
        uint256 pass;
    }

    Proposal[] public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted; // Track if an address has voted

    event ProposalCreated(uint256 indexed proposalId, string title, string description);
    event Voted(uint256 indexed proposalId, address indexed voter, string choice);

    function create(string memory _title, string memory _description) public {
        proposals.push(Proposal(_title, _description, 0, 0, 0));
        emit ProposalCreated(proposals.length - 1, _title, _description);
    }

    function vote(uint256 proposalId, uint8 choice) public {
        require(proposalId < proposals.length, "Invalid proposal ID");
        require(!hasVoted[proposalId][msg.sender], "You have already voted");

        Proposal storage proposal = proposals[proposalId];

        if (choice == 1) {
            proposal.approve += 1;
        } else if (choice == 2) {
            proposal.reject += 1;
        } else {
            proposal.pass += 1;
        }

        hasVoted[proposalId][msg.sender] = true;
        emit Voted(proposalId, msg.sender, choice == 1 ? "Approve" : choice == 2 ? "Reject" : "Pass");
    }

    function calculateCurrentState(uint256 proposalId) public view returns (bool) {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        uint256 totalVotes = proposal.approve + proposal.reject + proposal.pass;
        
        if (totalVotes == 0) {
            return false; // If no votes, the proposal fails
        }

        // If at least 60% of total votes are in favor, proposal succeeds
        return (proposal.approve * 100 >= totalVotes * 60);
    }
}
