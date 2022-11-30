// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2015, 2016, 2017 Dapphub
// Adapted by Ethereum Community 2021
pragma solidity 0.7.6;

//WETH9
interface WETH9Like {
    function withdraw(uint) external;
    function deposit() external payable;
    function transfer(address, uint) external returns (bool);
    function transferFrom(address, address, uint) external returns (bool);
}
//WETH10
interface WETH10Like {
    function depositTo(address) external payable;
    function withdrawFrom(address, address, uint256) external;
}
//Weth转换
contract WethConverter {
    WETH9Like constant private weth9 = WETH9Like(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); // ETH wrapper contract v9
    WETH10Like constant private weth10 = WETH10Like(0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F); // ETH wrapper contract v10
    
    receive() external payable {}
    ///从9到10
    function weth9ToWeth10(address account, uint256 value) external payable {
        //转账到当前合约
        weth9.transferFrom(account, address(this), value);
        //提现到当前合约
        weth9.withdraw(value);
        //当前合约质押给账户weth10
        weth10.depositTo{value: value + msg.value}(account);
    }
    ///从10到9
    function weth10ToWeth9(address account, uint256 value) external payable {
        //weth10提现到当前合约
        weth10.withdrawFrom(account, address(this), value);
        uint256 combined = value + msg.value;
        //当前合约质押
        weth9.deposit{value: combined}();
        //转weth9给account账户
        weth9.transfer(account, combined);
    }
}
