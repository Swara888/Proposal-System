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
Explanation:
