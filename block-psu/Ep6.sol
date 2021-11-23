// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

interface IShowable {
    enum Day {
        MON,
        THE
    }
    struct S1 {
        uint256 i;
        bool b;
    }

    function show() external returns (uint256);
}

interface IPrintable is IShowable {
    function print() external returns (uint256);
}

contract Draw is IPrintable {
    function show() public pure override returns (uint256) {
        return 1;
    }

    function print() public pure override returns (uint256) {
        return 2;
    }
}

contract Test {
    IShowable iShowable = new Draw();
    IPrintable iPrintable;

    constructor(address _drawAddress) {
         iPrintable = IPrintable(_drawAddress);
    }

    function test() public returns (uint256) {
        return iPrintable.print();
    }
}
