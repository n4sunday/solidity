# EP7

- Payable address with contract
- Ether tran
- fallback() vs receive()

## Payable address with contract

- how to deposit to smart contract, view address(this).balance
- how to withdraw from smart contract

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Ep7 {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function widtdraw() external payable {
        payable(msg.sender).transfer(address(this).balance);
    }

    function showBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

```

## 3 ways to transfer Ether to \_to (payable) from function executor (msg.sender)

- `_to.transfer(amt)` 2300 gas limit, throw error
- `bool res = _to.send(amt)` 2300 gas limit
- `(bool b, bytes memory res) = _to.call{msg.value}(data)`

## Special Function

### Fallback Function

`fallback() is executed`

- send ether to contract (with no receive() or non empty msg.data)
- call non-exist function

```ts
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
}

contract MyFallback {
    event log(string);

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

```

### Receive Function

`receive() is executed`

- if msg.data = empty && have receive()
- otherwise => call fallback()

```ts
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
```
