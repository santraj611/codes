const std = @import("std");

pub const ModbusErrors = error{
    ModbusError,
    ModbusFunctionNotSupportedError,
    DuplicatedKeyError,
    MissingKeyError,
    InvalidModbusBlockError,
    InvalidArgumentError,
    OverlapModbusBlockError,
    OutOfModbusBlockError,
    ModbusInvalidResponseError,
    ModbusInvalidRequestError,
};
