const std = @import("std");
const net = std.net;
const posix = std.posix;
const defines = @import("defines.zig");

const ResponseError = error{
    InvalidResponse,
};

const SimulatorRpcClient = struct {
    /// Make possible to send command to the modbus_tk.Simulator thanks to Remote Process Call
    host: []const u8,
    port: u16,
    timeout: u16,

    pub fn init(host: []const u8, port: u32, timeout: u32) SimulatorRpcClient {
        return .{
            .host = host,
            .port = port,
            .timeout = timeout,
        };
    }

    fn rpc_call(self: *SimulatorRpcClient, query: []const u8) ![]const u8 {
        // send a rpc call and return the result
        const addr = try net.Address.parseIp(self.host, self.port);
        var stream = try net.tcpConnectToAddress(addr);
        defer stream.close();
        try stream.writeAll(query);

        var buf: [1024]u8 = undefined;
        const n = try stream.read(buf[0..]);

        const response = buf[0..n];

        const response_buff = std.mem.trim(u8, response, "\r\n");

        const split_it = std.mem.splitAny(u8, query, " ");
        return self.response_to_values(response_buff, split_it[0]);

        // sock = socket.socket(socket.af_inet, socket.sock_stream)
        // sock.settimeout(self.timeout)
        // sock.connect((self.host, self.port))
        // sock.send(query)
        // response = sock.recv(1024)
        // sock.close()
        // return self._response_to_values(response.strip("\r\n"), query.split(" ")[0])
    }

    ///     extract the return value from the response
    fn response_to_values(self: *SimulatorRpcClient, response: []const u8, command: []const u8) ResponseError![]const u8 {
        _ = self.timeout;
        const prefix = command ++ " done: ";
        if (std.mem.startsWith(u8, response, prefix)) {
            return response[prefix.len..];
        } else {
            return ResponseError.InvalidResponse;
        }
        //     prefix = command + " done: "
        //     if response.find(prefix) == 0:
        //         return response[len(prefix):]
        //     else:
        //         raise Exception(response)
    }

    // add a new slave with the given id
    fn add_slave(self: *SimulatorRpcClient, slave_id: usize) ![]const u8 {
        var buff: [20]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "add_slave {d}", .{slave_id});
        return self.rpc_call(query);
    }

    // add a new slave with the given id
    fn remove_slave(self: *SimulatorRpcClient, slave_id: usize) ![]const u8 {
        var buff: [20]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "remove_slave {d}", .{slave_id});
        return self.rpc_call(query);
    }

    // add a new slave with the given id
    fn remove_all_slaves(self: *SimulatorRpcClient) ![]const u8 {
        const query: []const u8 = "remove_all_slaves";
        self.rpc_call(query);
    }

    // add a new slave with the given id
    fn has_slave(self: *SimulatorRpcClient, slave_id: usize) bool {
        var buff: [20]u8 = undefined;
        const query: []const u8 = std.fmt.bufPrint(&buff, "has_slave {d}", .{slave_id});
        if (std.mem.eql(u8, "1", self.rpc_call(query))) {
            return true;
        }
        return false;
    }

    /// add a new modbus block into the slave
    fn add_block(self: *SimulatorRpcClient, slave_id: usize, block_name: []const u8, block_type: anytype, starting_address: []const u8, length: usize) ![]const u8 {
        var buff: [40]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "add_block {d} {s} {d} {s} {d}", .{ slave_id, block_name, block_type, starting_address, length });
        return self.rpc_call(query);
    }

    /// remove the modbus block with the given name and slave
    fn remove_block(self: *SimulatorRpcClient, slave_id: usize, block_name: []const u8) ![]const u8 {
        var buff: [40]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "remove_block {d} {s}", .{ slave_id, block_name });
        return self.rpc_call(query);
    }

    /// remove the modbus block with the given name and slave
    fn remove_all_blocks(self: *SimulatorRpcClient, slave_id: usize) ![]const u8 {
        var buff: [40]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "remove_all_blocks {d}", .{slave_id});
        return self.rpc_call(query);
    }

    /// set the values of registers
    fn set_values(self: *SimulatorRpcClient, slave_id: usize, block_name: []const u8, address: []const u8, values: []const u8) ![]const u8 {
        var buff: [40]u8 = undefined;
        const query: []const u8 = try std.fmt.bufPrint(&buff, "set_values {d} {s} {d}", .{ slave_id, block_name, address });

        for (values) |val| {
            query += " " ++ @as([]const u8, val);
        }
        return self.rpc_call(query);

        // query = "set_values %d %s %d" % (slave_id, block_name, address)
        // for val in values:
        //     query += (" " + str(val))
        // return self._rpc_call(query)
    }

    // get the values of some registers
    // fn get_values(self: *SimulatorRpcClient, slave_id: usize, block_name: []const u8, address: []const u8, length: usize)  {
    // query = "get_values %d %s %d %d" % (slave_id, block_name, address, length)
    // ret_values = self._rpc_call(query)
    // return tuple([int(val) for val in ret_values.split(' ')])
    // }

    // fn install_hook(self, hook_name, fct_name) {
    //     """add a hook"""
    //     query = "install_hook %s %s" % (hook_name, fct_name)
    //     self._rpc_call(query)
    // }

    // fn uninstall_hook(self, hook_name, fct_name="") {
    //     """remove a hook"""
    //     query = "uninstall_hook %s %s" % (hook_name, fct_name)
    //     self._rpc_call(query)
    // }
};
