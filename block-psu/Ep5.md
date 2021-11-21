# EP4

## Inheritance

use `is`

- `public` เรียกใช้ที่ไหนก็ได้
- `private` เรียกใช้ได้เฉพาะใน contract นั้นเท่านั้น
- `internal` contract ที่ inheritance มาสามารถใช้ได้ ใช้ภายในได้
- `external` เรียกจากนอก class ไม่สามารถเรียกใช้ใน contract

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint count;

    function foo() public pure returns (uint) {
        return 1;
    }
}

contract Child is Parent {
    function test() public view returns (uint) {
        return count;
    }
}
```

## Overload Function

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public pure returns (uint256) {
        return 1;
    }

    function foo(uint256 a) public pure returns (uint256) {
        return 2;
    }

    function foo(bool b) public pure returns (uint256) {
        return 3;
    }
}
```

## Override Function

- `virtual` ใน Parent
- `override` ใน Child

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public pure virtual returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    function foo() public pure override returns (uint256) {
        return 2;
    }
}

```

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() external returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    function foo() public pure override returns (uint256) {
        return 2;
    }
}

```

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public pure virtual returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    function foo() public pure virtual override returns (uint256) {
        return 2;
    }
}

contract ChildTwo is Parent {
    function foo() public pure override returns (uint256) {
        return 3;
    }
}
```

## Super

use `super.foo();`

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public pure virtual returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    function foo() public pure override returns (uint256) {
        return super.foo();
    }
}

```

use `Parent p = new Parent();` and `p.foo();`

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public view virtual returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    Parent p = new Parent();

    function foo() public view override returns (uint256) {
        return p.foo();
    }
}

```

use `Parent.foo();`

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    function foo() public view virtual returns (uint256) {
        return 1;
    }
}

contract Child is Parent {
    function foo() public view override returns (uint256) {
        return Parent.foo();
    }
}
```

## Super and Constructor

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    constructor(uint256 _count) {
        count = _count;
    }

    function foo() public view virtual returns (uint256) {
        return count;
    }
}

contract Child is Parent(5) {
    Parent p = new Parent(1);

    function foo() public view override returns (uint256) {
        return Parent.foo();
    }
}
```

use `construct in child`

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;

    constructor(uint256 _count) {
        count = _count;
    }

    function foo() public view virtual returns (uint256) {
        return count;
    }
}

contract Child is Parent {
    Parent p = new Parent(1);

    constructor(uint256 _count) Parent(_count) {}

    function foo() public view override returns (uint256) {
        return Parent.foo();
    }
}
```

## Multi Parent

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;
    event Log(uint256);

    constructor() {
        emit Log(0);
    }

    function foo() public view virtual returns (uint256) {
        return count;
    }
}

contract ParentOne {
    event LogOne(uint256);

    constructor() {
        emit LogOne(1);
    }
}

contract Child is Parent, ParentOne {
    // Parent p = new Parent();

    constructor() Parent() ParentOne() {}

    function foo() public view override returns (uint256) {
        return Parent.foo();
    }
}

```

- เมื่อเรียกใช้ super จะอ้างอิงตัวขวา

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

contract Parent {
    uint256 count;
    event Log(uint256);

    constructor() {
        emit Log(0);
    }

    function foo() public virtual returns (uint256) {
        emit Log(0);
        return 0;
    }
}

contract ParentOne {
    event LogOne(uint256);

    constructor() {
        emit LogOne(1);
    }

    function foo() public virtual returns (uint256) {
        emit LogOne(1);
        return 1;
    }
}

contract Child is Parent, ParentOne {
    // Parent p = new Parent();

    constructor() Parent() ParentOne() {}

    function foo() public override(Parent, ParentOne) returns (uint256) {
        return super.foo();
    }
}
```

## 🚀 Implement Inheritance ERC20

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract BlockS is ERC20 {
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, 10000 * 10**uint256(decimals()));
    }
}
```
