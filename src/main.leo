// The 'occupancy' program.
program occupancy.aleo {
    // A token, issued by a bank.
    // - 'owner'  : The address of the account that owns the record associated with this token.
    // - 'gates'  : The value associated with the record (always zero).
    // - 'is_vote' : The is_vote of tokens .
    record Token {
        owner: address,
        gates: u64,
        is_vote: bool,
    }

    record VoteToken {
        owner: address,
        gates: u64,
        vote_number: u64,
        id_number: u64
    }


    // An on-chain mapping, storing the amount of tokens owned by each account
    // The account is stored as a to preserve user privacy.
    mapping vote_numbers: field => u64;



    transition account(owner: address) -> Token {
        assert_eq(self.caller, aleo1pkwax8m3z8mmqtjs9h3p0zk7lycpnnq6txt4wch3t3ee0s3vyy8sjqz8d2);
        return Token {
            owner: owner,
            gates: 0u64,
            is_vote: false,
        };
    }
  
   transition optionVote(owner: address,id_number:u64) -> VoteToken {
        assert_eq(self.caller, aleo1pkwax8m3z8mmqtjs9h3p0zk7lycpnnq6txt4wch3t3ee0s3vyy8sjqz8d2);
        return VoteToken {
            owner: owner,
            gates: 0u64,
            vote_number:0u64,
            id_number: id_number,
        };
    }

 transition results(vote: VoteToken) -> VoteToken {
        assert_eq(self.caller, aleo1pkwax8m3z8mmqtjs9h3p0zk7lycpnnq6txt4wch3t3ee0s3vyy8sjqz8d2);
        return VoteToken {
            owner: vote.owner,
            gates: vote.gates,
            vote_number:vote.vote_number,
            id_number: vote.id_number,
        };
    }

    transition castVote(token: Token,vote: VoteToken) -> VoteToken {
 
        let remaining: VoteToken = VoteToken {
            owner: vote.owner,
            gates: vote.gates,
            vote_number:vote.vote_number + 1u64,
            id_number: vote.id_number,
        };

        // Compute the hash of the token owner.
        let hash: field = BHP256::hash_to_field(vote.owner);
        return remaining then finalize (hash);
    }

    // Updates on-chain state by the amount of tokens deposited.
    // - `hash`  : The hash of the token owner.
    // - `amount`: The amount of tokens that were deposited.
    finalize castVote(hash: field) {
        let vote_number: u64 = Mapping::get_or_use(vote_numbers, hash, 0u64);
        Mapping::set(vote_numbers, hash, vote_number + 1u64);
    }

}
