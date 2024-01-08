// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {BuyMeACoffee} from "../src/BuyMeACoffee.sol";

contract DeployBuyMeACoffee is Script {
    function run() public returns (BuyMeACoffee) {
        vm.startBroadcast();
        BuyMeACoffee buyMeACoffee = new BuyMeACoffee();

        vm.stopBroadcast();
        return buyMeACoffee;
    }
}
