const std = @import("std");
const testing = std.testing;
const types = @import("./types.zig");

const raw = @import("./raw.zig");

pub const IoUringSq = struct {
    kHead: *u32,
    kTail: *u32,
    kRingMask: *u32,
    kRingEntries: *u32,
    kFlags: *u32,
    kDropped: *u32,
    array: *u32,
    sqes: *std.os.linux.io_uring_sqe,
    sqeHead: u32,
    sqeTail: u32,
    ringSz: isize,
    ringPtr: *anyopaque,
    ringMask: u32,
    ringEntries: u32,
    pad: [2]u32,
};

pub const IoUringCq = struct {
    kHead: *u32,
    kTail: *u32,
    kRingMask: *u32,
    kRingEntries: *u32,
    kFlags: *u32,
    kOverflow: *u32,
    cqes: *std.os.linux.io_uring_cqe,
    ringSz: isize,
    ringPtr: *anyopaque,
    ringMask: u32,
    ringEntries: u32,
    pad: [2]u32,
};

pub const IoUring = struct {
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

pub const IoUringZcrxRq = struct {
    kHead: *u32,
    kTail: *u32,
    rqTail: u32,
    ringEntries: u32,
    rqes: *IoUringZcrxRqe,
    ringPtr: *anyopaque,
};

pub const IoUringZcrxRqe = struct {
    off: u64,
    len: u32,
    __pad: u32,
};

pub const IoUringParams = struct {
    sq_entries: u32,
    cq_entries: u32,
    flags: u32,
    sq_thread_cpu: u32,
    sq_thread_idle: u32,
    features: u32,
    wq_fd: u32,
    resv: [3]u32,
    sq_off: IoSqringOffsets,
    cq_off: IoCqringOffsets,
};

pub const IoSqringOffsets = struct {
    head: u32,
    tail: u32,
    ring_mask: u32,
    ring_entries: u32,
    flags: u32,
    dropped: u32,
    array: u32,
    resv1: u32,
    user_addr: u64,
};

pub const IoCqringOffsets = struct {
    head: u32,
    tail: u32,
    ring_mask: u32,
    ring_entries: u32,
    overflow: u32,
    cqes: u32,
    flags: u32,
    resv1: u32,
    user_addr: u64,
};

// FIXME: rewrite this
pub const IoUringProbe = raw.struct_io_uring_probe;

pub fn IoUringGetProbeRing(ring: *raw.io_uring) IoUringProbe {
    // FIXME: Add error handling
    return raw.struct_io_uring_probe(ring);
}

pub fn IoUringGetProbe() IoUringProbe {
    // FIXME: Add error handling
    return raw.io_uring_get_probe();
}

pub fn IoUringFreeProbe(probe: *IoUringProbe) void {
    // FIXME: Add error handling
    return raw.io_uring_free_probe(probe);
}

inline fn IoUringOpcodeSupported(p: *const IoUringProbe, op: i32) i32 {
    // FIXME: Add error handling
    return raw.io_uring_opcode_supported(p, op);
}

pub fn ioUringQueueInitMem(entries: u32, ring: *IoUring, p: IoUringParams, buf: *anyopaque, buf_size: usize) i32 {
    // FIXME: Add error handling
    return raw.io_uring_queue_init_mem(entries, ring, p, buf, buf_size);
}
