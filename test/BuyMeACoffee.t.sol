// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {BuyMeACoffee} from "../src/BuyMeACoffee.sol";

contract BuyMeACoffeeTest is Test {
    BuyMeACoffee buyMeACoffee;

    address USER = makeAddr("Azan");
    address OWNER = makeAddr("owner");

    function setUp() external {
        vm.deal(OWNER, 1 ether);
        vm.prank(OWNER);
        buyMeACoffee = new BuyMeACoffee();
        vm.deal(USER, 1 ether);
    }

    function testOwner() external {
        assertEq(buyMeACoffee.getOwner(), OWNER);
    }

    function testBuyCoffee() external {
        buyMeACoffee.buyCoffee{value: 1 ether}("ALI", "losser.");
        assertEq(buyMeACoffee.getMemos().length, 1);
    }

    function testBuyMeWithPrank() external {
        vm.prank(USER);
        buyMeACoffee.buyCoffee{value: 1 ether}("Azan", "you are broke");
        assertEq(USER.balance, 0 ether);
    }

    function testBuyMeCoffeeBalanceAfterBuying() external view {
        require(address(this).balance > 0, "balance is zero");
    }

    function testMemos() external {
        buyMeACoffee.buyCoffee{value: 1 ether}("ALI", "losser.");

        string memory name = buyMeACoffee.getMemos()[0].name;

        assertEq(name, "ALI");
    }

    function testWithdrawTips() external {
        // Arange
        vm.prank(USER);
        buyMeACoffee.buyCoffee{value: 0.5 ether}("Azan", "you are broke");

        uint256 buyMeACoffeeStartingBalance = address(buyMeACoffee).balance;
        uint256 ownerStartingBalance = buyMeACoffee.getOwner().balance;

        // Act
        buyMeACoffee.withdrawTips();

        // Assert
        uint256 buyMeACoffeeEndingBalance = address(buyMeACoffee).balance;
        uint256 ownerEndingBalance = buyMeACoffee.getOwner().balance;

        assertEq(buyMeACoffeeEndingBalance, 0);
        assertEq(
            ownerEndingBalance,
            ownerStartingBalance + buyMeACoffeeStartingBalance
        );
    }
}
