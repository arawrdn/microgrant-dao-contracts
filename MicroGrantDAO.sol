// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title Minimal DAO for Micro-Grants
/// @notice Owner can create grant proposals, members vote, and execute payouts
contract MicroGrantDAO {
    address public owner;
    uint256 public proposalCount;

    struct Proposal {
        string description;
        address payable recipient;
        uint256 amount;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    /// @notice Emitted when a new proposal is created
    event ProposalCreated(uint256 indexed id, string description, address recipient, uint256 amount);

    /// @notice Emitted when a vote is cast
    event Voted(uint256 indexed id, address voter, bool support);

    /// @notice Emitted when a proposal is executed
    event ProposalExecuted(uint256 indexed id, bool success);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Owner creates a new grant proposal
    function createProposal(string calldata description, address payable recipient, uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be > 0");
        proposalCount++;
        proposals[proposalCount] = Proposal({
            description: description,
            recipient: recipient,
            amount: amount,
            votesFor: 0,
            votesAgainst: 0,
            executed: false
        });

        emit ProposalCreated(proposalCount, description, recipient, amount);
    }

    /// @notice Cast vote for a proposal
    function vote(uint256 proposalId, bool support) external {
        Proposal storage p = proposals[proposalId];
        require(p.recipient != address(0), "Proposal does not exist");
        require(!hasVoted[proposalId][msg.sender], "Already voted");
        require(!p.executed, "Already executed");

        hasVoted[proposalId][msg.sender] = true;

        if (support) {
            p.votesFor++;
        } else {
            p.votesAgainst++;
        }

        emit Voted(proposalId, msg.sender, support);
    }

    /// @notice Execute a proposal if it has more votes for than against
    function executeProposal(uint256 proposalId) external {
        Proposal storage p = proposals[proposalId];
        require(p.recipient != address(0), "Proposal does not exist");
        require(!p.executed, "Already executed");
        require(p.votesFor > p.votesAgainst, "Not enough support");
        require(address(this).balance >= p.amount, "Insufficient funds");

        p.executed = true;
        (bool success, ) = p.recipient.call{value: p.amount}("");
        emit ProposalExecuted(proposalId, success);
    }

    /// @notice Deposit ETH to fund the DAO
    receive() external payable {}

    /// @notice Fallback in case someone sends ETH to contract
    fallback() external payable {}
}

