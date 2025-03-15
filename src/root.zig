const std = @import("std");
const linux = std.os.linux;
const testing = std.testing;

const liburing = @cImport(@cInclude("liburing.h"));
const mman = @cImport(@cInclude("sys/mman.h"));

const IoUringSq = struct {
    kHead: *u32,
    kTail: *u32,
    kRingMask: *u32,
    kRingEntries: *u32,
    kFlags: *u32,
    kDropped: *u32,
    array: *u32,
    sqes: *linux.io_uring_sqe,
    sqeHead: u32,
    sqeTail: u32,
    ringSz: isize,
    ringPtr: *anyopaque,
    ringMask: u32,
    ringEntries: u32,
    pad: [2]u32,
};

const IoUringCq = struct {
    kHead: *u32,
    kTail: *u32,
    kRingMask: *u32,
    kRingEntries: *u32,
    kFlags: *u32,
    kOverflow: *u32,
    cqes: *linux.io_uring_cqe,
    ringSz: isize,
    ringPtr: *anyopaque,
    ringMask: u32,
    ringEntries: u32,
    pad: [2]u32,
};

const IoUring = struct {
    sq: IoUringSq,
    cq: IoUringCq,
    flags: u32,
    ringFd: i32,
    features: u32,
    enterRingFd: i32,
    intFlags: u8,
    pad: [3]u8,
    pad2: u32,
};

const IoUringZcrxRq = struct {
    // __u32 *khead;
    kHead: *u32,
    // __u32 *ktail;
    kTail: *u32,
    // __u32 rq_tail;
    rqTail: u32,
    // unsigned ring_entries;
    ringEntries: u32,
    // struct io_uring_zcrx_rqe *rqes;
    rqes: *IoUringZcrxRqe,
    // void *ring_ptr;
    ringPtr: *anyopaque,
};

const IoUringZcrxRqe = struct {
    off: u64,
    len: u32,
    __pad: u32,
};



