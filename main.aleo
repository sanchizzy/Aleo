program aleo_sanchizzy.aleo;

record card:
    owner as address.private;
    number as u64.private;
    cvv as u8.private;
    amt as u64.private;


mapping account:
	key as field.public;
	value as u64.public;


mapping asset_owner:
	key as field.public;
	value as u32.public;

closure check_addr:
    input r0 as address;
    is.eq r0 self.caller into r1;
    not r1 into r2;
    or r2 true into r3;
    assert.eq r3 true;
    not r1 into r4;
    not r4 into r5;
    or r5 false into r6;
    assert.eq r6 true;
    output true as boolean;


function generate_card:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    input r3 as u64.private;
    call check_addr r0 into r4;
    hash.bhp256 r0 into r5 as field;
    hash.bhp256 r0 into r6 as u64;
    hash.bhp256 r0 into r7 as u8;
    cast r0 r6 r7 r3 into r8 as card.record;
    output r8 as card.record;


function get_faucet:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u8.private;
    input r3 as u64.private;
    call check_addr r0 into r4;
    hash.bhp256 r0 into r5 as field;
    hash.bhp256 r0 into r6 as u64;
    hash.bhp256 r0 into r7 as u8;
    cast r0 r6 r7 r3 into r8 as card.record;
    async get_faucet r5 r3 into r9;    output r8 as card.record;
    output r9 as aleo_sanchizzy.aleo/get_faucet.future;

finalize get_faucet:
    input r0 as field.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];


function get_asset:
    input r0 as card.record;
    call check_addr r0.owner into r1;
    hash.bhp256 r0.owner into r2 as field;
    hash.bhp256 r0.owner into r3 as u64;
    hash.bhp256 r0.owner into r4 as u8;
    sub r0.amt 10u64 into r5;
    hash.bhp256 r3 into r6 as u32;
    cast r0.owner r3 r4 r5 into r7 as card.record;
    async get_asset r2 r5 r6 into r8;    output r7 as card.record;
    output r6 as u32.private;
    output r8 as aleo_sanchizzy.aleo/get_asset.future;

finalize get_asset:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as u32.public;
    get.or_use account[r0] 0u64 into r3;
    sub r3 r1 into r4;
    set r4 into account[r0];
    set r2 into asset_owner[r0];
