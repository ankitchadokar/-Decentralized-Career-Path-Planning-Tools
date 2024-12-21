// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CareerPathPlanning {
    struct CareerGoal {
        string title;
        string description;
        bool achieved;
    }

    mapping(address => CareerGoal[]) public careerGoals;

    event CareerGoalAdded(address indexed user, string title, string description);
    event CareerGoalAchieved(address indexed user, string title);

    function addCareerGoal(string memory _title, string memory _description) public {
        careerGoals[msg.sender].push(CareerGoal(_title, _description, false));
        emit CareerGoalAdded(msg.sender, _title, _description);
    }

    function markCareerGoalAsAchieved(uint _index) public {
        require(_index < careerGoals[msg.sender].length, "Invalid goal index.");
        CareerGoal storage goal = careerGoals[msg.sender][_index];
        require(!goal.achieved, "Goal already achieved.");
        goal.achieved = true;
        emit CareerGoalAchieved(msg.sender, goal.title);
    }

    function getCareerGoals() public view returns (CareerGoal[] memory) {
        return careerGoals[msg.sender];
    }

    function getCareerGoal(address _user, uint _index) public view returns (string memory, string memory, bool) {
        require(_index < careerGoals[_user].length, "Invalid goal index.");
        CareerGoal memory goal = careerGoals[_user][_index];
        return (goal.title, goal.description, goal.achieved);
    }
}
