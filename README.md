# Openzeppelin权限控制实践

### 所有者合约Ownable.sol

Ownable合约模块提供了基本的访问控制机制，用于管理所有者，并设置特定函数的独占访问权限。

- 修饰符

```
onlyOwner()：只有Owner才能执行函数。
```

- 方法列表

```
owner()：获取Owner地址。
_checkOwner()：检查msg.sender是否是Owner。
renounceOwnership()：销毁Owner, 设置Owner为0地址。
transferOwnership(newOwner)：转移Owner。
_transferOwnership(address newOwner)：转移Owner，内部函数。
```

- 事件列表
  
```
OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```

- 错误列表
  
```
OwnableUnauthorizedAccount(address account)
OwnableInvalidOwner(address owner)
```

### 权限控制合约AccessControl.sol

AccessControl合约模块提供了可设置的角色权限控制机制，可自定义角色和设置特定函数的角色访问权限。

- 修饰符
  
```
onlyRole(role)：只有指定角色才能执行函数。
```

- 方法列表

```
supportsInterface(interfaceId)：查看支持的接口。
hasRole(role, account)：查看角色是否已授权账户。
_checkRole(role)：检查msg.sender的角色权限。
_checkRole(role, account)：检查指定账户的角色权限。
getRoleAdmin(role)：获取管理员角色。
grantRole(role, account)：给账户授权角色
revokeRole(role, account)：撤销账户授权角色
renounceRole(role, callerConfirmation)：从Call账户中撤销
_setRoleAdmin(role, adminRole)：设置管理员角色
_grantRole(role, account)：给账户授权角色
_revokeRole(role, account)：撤销账户授权角色
DEFAULT_ADMIN_ROLE()：默认管理员角色
```
- 事件列表

```
RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole)
RoleGranted(bytes32 indexed role, address indexed account, address indexed sender)
RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender)
```
- 错误列表

```
AccessControlUnauthorizedAccount(address account, bytes32 neededRole)
AccessControlBadConfirmation()
```

### 权限管理合约AccessManager.sol

AccessManager合约是一个存储系统权限的中央合约，提供更强大的权限管理方案。

- 修饰符
  
```
onlyAuthorized()：只有超级管理员才能执行函数。
```

- 方法列表

```
canCall(caller, target, selector)：检查地址 ( caller) 是否有权直接调用给定合约上的给定函数（无限制）
expiration()：预定提案的到期延迟。默认为 1 周。
minSetback()：所有延迟更新的最小Setback。
isTargetClosed(target)：获取合约是否已关闭并禁用任何访问。
getTargetFunctionRole(target, selector)：获取调用函数所需的角色。
getTargetAdminDelay(target)：获取目标合约的管理延迟。合约配置的更改会受到此延迟的影响。
getRoleAdmin(roleId)：获取充当给定角色管理员的角色 ID。
getRoleGuardian(roleId)：获取充当给定角色监护人的角色。
getRoleGrantDelay(roleId)：获取角色当前的授予延迟。
getAccess(roleId, account)：获取给定角色的给定帐户的访问详细信息。
hasRole(roleId, account)：检查给定帐户当前是否具有与给定角色对应的权限级别。
labelRole(roleId, label)：为角色提供标签，以提高 UI 的角色可发现性。
grantRole(roleId, account, executionDelay)：添加account到roleId或更改其执行延迟。
revokeRole(roleId, account)：从角色中删除帐户，立即生效。
renounceRole(roleId, callerConfirmation)：立即放弃调用帐户的角色权限。
setRoleAdmin(roleId, admin)：更改给定角色的管理员角色。
setRoleGuardian(roleId, guardian)：更改给定角色的监护人角色。
setGrantDelay(roleId, newDelay)：更新授予roleId。
setTargetFunctionRole(target, selectors, roleId)：selectors设置调用合约中标识的函数所需的角色target。
setTargetAdminDelay(target, newDelay)：设置更改给定目标合约配置的延迟。
setTargetClosed(target, closed)：设置合约的关闭标志。
getSchedule(id)：返回计划操作准备好执行的时间点。
getNonce(id)：返回具有给定 id 的最新计划操作的随机数。
schedule(target, data, when)：安排一个延迟操作以供将来执行，并返回操作标识符。
execute(target, data)：执行延迟受限的函数，前提是事先已正确调度，或者执行延迟为 0。
cancel(caller, target, data)：取消预定（延迟）的操作。返回标识先前计划的已取消操作的随机数。
consumeScheduledOp(caller, data)：使用针对调用者的计划操作。
hashOperation(caller, target, data)：用于延迟操作的哈希函数。
updateAuthority(target, newAuthority)：更改此管理器实例管理的目标的权限。
```