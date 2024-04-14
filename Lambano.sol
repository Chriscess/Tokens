// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Chrisces is IERC20 {

    string public name = "Chrisces";
    string public symbol = "CHS";
    uint8 public decimals = 3;

    uint256 private _totalSupply;
    address private owner;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _totalSupply = 100 * (10 ** decimals);
        owner = msg.sender;
        _balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function mint(uint _amount) external {
        require(msg.sender == owner, "not owner");
        _balances[msg.sender] += _amount;
        _totalSupply += _amount;
    }

    function burn(uint _amount) external {
        require(_balances[msg.sender] >= _amount, "Not enough balance");
        _balances[msg.sender] -= _amount;
        _totalSupply -= _amount;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "transfer to the zero address");
        require(_balances[msg.sender] >= amount, "transfer amount exceeds balance");
        
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address _owner, address spender) public view override returns (uint256) {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(sender != address(0), "transfer from the zero address");
        require(recipient != address(0), "transfer to the zero address");
        require(_balances[sender] >= amount, "transfer amount exceeds balance");
        require(_allowances[sender][msg.sender] >= amount, "transfer amount exceeds allowance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }
}
