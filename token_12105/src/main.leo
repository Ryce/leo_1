// The 'token_12105' program.
program token_12105.aleo {

    mapping balance: address => u64;

    record Token {
        owner: address;
        balance: u64;
    }

    transition mint(amount: u64) -> Token {
        return Token {
            owner: self.caller,
            balance: amount,
        };
    }

    transition transfer_private(receiver: address, amount: u64, input: Token) -> (Token, Token) {
        let remaining: u64 = input.balance - amount;

        let caller: Token = Token {
            owner: self.caller,
            balance: remaining,
        };
        let recipient: Token = Token {
            owner: receiver,
            balance: amount,
        };
        return (caller, recipient);
    }

    transition transfer_private_to_public(receiver: address, amount: u64, input: Token) -> Token {
        let remaining: u64 = input.balance - amount;

        let caller: Token = Token {
            owner: self.caller,
            balance: remaining,
        };
        return caller then finalize (receiver, amount);
    }

    finalize transfer_private_to_public(receiver: address, amount: u64) {
        // get previous balacne of receiver
        let previous: u64 = Mapping::get_or_use(balance, receiver, 0u64);
        // update balance of receiver
        Mapping::set(balance, receiver, previous + amount);
    }

    transition transfer_public_to_private(receiver: address, amount: u64) -> Token {
        return Token {
            owner: receiver,
            balance: amount,
        } then finalize(self.caller, amount);
    }

    finalize transfer_public_to_private(caller: address, amount: u64) {
        // get previous balacne of caller
        let previous: u64 = Mapping::get(balance, caller);
        // update balance of caller
        Mapping::set(balance, caller, previous - amount);
    }

    transition join(input: Token, input2: Token) -> Token {
        return Token {
            owner: self.caller,
            balance: input.balance + input2.balance,
        };
    }

    transition main(public a: field, b: field) -> field {
        assert_eq((a - 10field) * (a - 13field), 0field);
        let c: field = a + b;
        return c;
    }
}
