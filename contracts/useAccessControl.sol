// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyToken is AccessControl {

    //定义角色
    bytes32 public constant ADMIN_ROLE   = keccak256("ADMIN_ROLE");
    bytes32 public constant TEACHER_ROLE = keccak256("TEACHER_ROLE");
    bytes32 public constant STUDENT_ROLE = keccak256("STUDENT_ROLE");

    //定义角色账户（Remix内置账户）
    address public constant admin    = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public constant teacher  = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public constant student1 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    address public constant student2 = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2;

    //学生成绩
    mapping(address => uint256) private grades;

    //是否可查看成绩
    bool public viewflag;

    constructor()  {
        _grantRole(ADMIN_ROLE,   admin);
        _grantRole(TEACHER_ROLE, teacher);
        _grantRole(STUDENT_ROLE, student1);
        _grantRole(STUDENT_ROLE, student2);

        viewflag=false;
    }

    //管理员打卡查看
    function openView() public onlyRole(ADMIN_ROLE) {
        viewflag=true;
    }

    //管理员关闭查看
    function closeView() public onlyRole(ADMIN_ROLE) {
        viewflag=false;
    }

    //老师设置分数
    function setGrade(address student, uint256 grade) public onlyRole(TEACHER_ROLE) {
        require(viewflag == true, "viewflag is false...");
        grades[student]=grade;
    }

    //学生查看分数
    function getGrade() public view onlyRole(STUDENT_ROLE) returns(uint256) {
        require(viewflag == true, "viewflag is false...");        
        return grades[msg.sender];
    }    
}
