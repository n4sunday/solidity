# EP6

- Interface
- Abstract contract
- Polymorphism
- Inside ERC-20

## Interface

Abstract the function

`Interface`

- use only `external`
- use `enum` or `struct`
- can't define variables, constructor(), function implementation, inherit contract, instantiate (object)

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;
interface IShowable {
    function show() external returns (uint256);
}
```

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

interface IShowable {
    enum Day { MON, THE }
    struct S1 { uint i; bool b;}

    function show() external returns (uint256);
}
```

`Implement interface`

```ts
// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

interface IShowable {
    enum Day {
        MON,
        THE
    }
    struct S1 { uint i; bool b;}

    function show() external returns (uint256);
}

contract Draw is IShowable {
    function show() public override pure returns (uint256) {
        return 1;
    }
}
```

## Abstract Contract

- use `virtual`
- ผสมระหว่าง interface กับ contract
- can't use `Print p = new Print()`

```ts
abstract contract Print {
    function test() public {}

    function functionWithOutImplement() public virtual;
}
```

```ts
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

abstract contract Print {
    function test() public {}

    function functionWithOutImplement() public virtual;
}

contract Draw is Print, IShowable {
    function show() public pure override returns (uint256) {
        return 1;
    }

    function functionWithOutImplement() public override {}
}
```

## Implement Multiple Interface

`Multiple Interface`

```ts
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

interface IPrintable {
    function print() external returns (uint256);
}

abstract contract Print {
    function test() public {}

    function functionWithOutImplement() public virtual;
}

contract Draw is Print, IShowable, IPrintable {
    function show() public pure override returns (uint256) {
        return 1;
    }

    function print() public pure override returns (uint256) {
        return 2;
    }

    function functionWithOutImplement() public override {}
}
```

`Interface Implement Interface`

```ts
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
```

## Polymorphism

```ts
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

    function test() public returns (uint256) {
        return iShowable.show();
    }
}

```

```ts
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

```
