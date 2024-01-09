// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {BuyMeACoffee} from "../src/BuyMeACoffee.sol";

contract DeployBuyMeACoffee is Script {
    function run() public {
        vm.startBroadcast();
        new BuyMeACoffee();

        vm.stopBroadcast();
    }
}
