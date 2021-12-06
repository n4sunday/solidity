// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Ep7 {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function widtdraw() external payable {
        // payable(msg.sender).transfer(address(this).balance);
        // bool b = owner.send(address(this).balance);
        // (bool b, ) = owner.call{value: address(this).balance}("");
    }

    function showBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function callFallback(address _contract) external payable {
        (bool b, ) = _contract.call{value: msg.value}("");
    }

    function call2Foo(address _contract) external payable {
        (bool b, ) = _contract.call{value: msg.value}(
            abi.encodeWithSignature("foobar()")
        );
    }

     function call2Receive(address _contract) external payable {
        (bool b, ) = _contract.call{value: msg.value}("");
    }
}

contract MyFallback {
    event log(string);

    receive() external payable {
        emit log("Call to receive()");
    }

    fallback() external payable {
        emit log("Call to fallback()");
    }

    function showBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function foo() external payable {
        emit log("call foo()");
    }
}
