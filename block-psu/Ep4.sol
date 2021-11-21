// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Ep4 {
    enum Status {
        PAID,
        UNPAAID
    }

    struct Guitar {
        uint256 price;
        string model;
        Status status;
        address owner;
    }

    address payable owner;

    mapping(uint256 => Guitar) private guitar;

    event BuyGuitar(uint256, string, bool);

    modifier checkCost(uint256 id) {
        require(msg.value >= guitar[id].price, "Not enouth ethers");
        _; // Body function
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function setGuitar(
        uint256 id,
        uint256 price,
        string memory model
    ) public {
        guitar[id] = Guitar(price, model, Status.UNPAAID, owner);
    }

    function getGuitar(uint256 id) public view returns (Guitar memory) {
        return guitar[id];
    }

    function buyGuitar(uint256 id)
        public
        payable
        checkCost(id)
        returns (Guitar memory)
    {
        guitar[id].status = Status.PAID;
        guitar[id].owner = msg.sender;

        (bool result, ) = owner.call{value: msg.value}("");
        emit BuyGuitar(id, guitar[id].model, result);
        return guitar[id];
    }
}
