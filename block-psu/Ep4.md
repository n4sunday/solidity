# EP4

### Mapping

- คล้ายกับ Array `mapping(key => value)` key เป็น type ไหนก็ได้
- สามารถสร้าง element 2 มิติได้
  `Ex`

```sol
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
    mapping(unit => string) a;

    function showSting() public {
        a[0] = "Luffy";
        a[1] = "Zoro";
        a[10] = "Jinba";
    }
}

```

```sol
pragma solidity 0.8.4;

contract Day4 {
    mapping(addresss => string) b;

    function showName() public {
        b[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = "Roger";
        b[0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c] = "Newget";
    }
}
```

```sol
pragma solidity 0.8.4;

contract Day4 {
    mapping(unit => mapping(unit => string)) c;

    function showTwoElement() public {
        c[10][11] = "Hello";
    }
}

```

📄 Index ไม่ต้องเรียง จะเก็บเฉพาะข้อมูลที่ใส่ไปเท่านั่น ต่างจาก Array ที่มีการจอง

### Mapping ,Struct and Enum

```sol
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
    struct Movie {
        string name;
        uint256 income;
    }

    mapping(uint256 => Movie) private movies;

    function setMovie(
        uint256 id,
        string memory name,
        uint256 income
    ) public {
        movies[id] = Movie(name, income);
    }

    function getMovie(uint256 id) public view returns (Movie memory) {
        return movies[id];
    }
}
```

📄 `constructor() {}` จะถูกเรียกอัตโนมัติเมื่อ deploy contract
📄 `msg.sender` ค่า address ผู้ที่ deploy smart contract หรือผู้ที่สั่ง run transaction นั้น

```sol
// SPDX-License-Identifier: Nolicense
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
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

    function buyGuitar(uint256 id) public payable returns (Guitar memory) {
        if (msg.value >= guitar[id].price) {
            guitar[id].status = Status.PAID;
            guitar[id].owner = msg.sender;

            owner.transfer(msg.value);
            // owner.send(msg.value);
        }
        return guitar[id];
    }
}
```

#### Require

```sol
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
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

    function buyGuitar(uint256 id) public payable returns (Guitar memory) {
        require(msg.value >= guitar[id].price, "Not enouth ethers");
        guitar[id].status = Status.PAID;
        guitar[id].owner = msg.sender;

        (bool result, ) = owner.call{value: msg.value}("");

        return guitar[id];
    }
}
```

#### Modifier

```sol
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
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

        return guitar[id];
    }
}
```

#### Event

```sol
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Day4 {
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

```
