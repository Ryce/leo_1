program token_12105.aleo;

record Token:
    owner as address.private;
    balance as u64.private;


mapping balance:
	key as address.public;
	value as u64.public;

function mint:
    input r0 as u64.private;
    cast self.caller r0 into r1 as Token.record;
    output r1 as Token.record;


function transfer_private:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as Token.record;
    sub r2.balance r1 into r3;
    cast self.caller r3 into r4 as Token.record;
    cast r0 r1 into r5 as Token.record;
    output r4 as Token.record;
    output r5 as Token.record;


function transfer_private_to_public:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as Token.record;
    sub r2.balance r1 into r3;
    cast self.caller r3 into r4 as Token.record;
    async transfer_private_to_public r0 r1 into r5;
    output r4 as Token.record;
    output r5 as token_12105.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use balance[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];


function main:
    input r0 as field.public;
    input r1 as field.private;
    sub r0 10field into r2;
    sub r0 13field into r3;
    mul r2 r3 into r4;
    assert.eq r4 0field;
    add r0 r1 into r5;
    output r5 as field.private;
