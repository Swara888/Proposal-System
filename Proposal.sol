// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProposalContract {
    struct Proposal {
        string title;
        string description;
    }

    Proposal[] public proposals;

    function create(string memory _title, string memory _description) public {
        proposals.push(Proposal(_title, _description));
    }
}
function calculateCurrentState() private view returns (bool) {
    Proposal storage proposal = proposal_history[counter];

    uint256 approve = proposal.approve;
    uint256 reject = proposal.reject;
    uint256 pass = proposal.pass;

    uint256 totalVotes = approve + reject + pass;
    
    if (totalVotes == 0) {
        return false; // Default to failed if no votes are cast
    }

    // Check if approvals are at least 60% of total votes
    if (approve * 100 >= totalVotes * 60) {
        return true; // Proposal succeeded
    } else {
        return false; // Proposal failed
    }
}

