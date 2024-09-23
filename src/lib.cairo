#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increment(ref self: TContractState);
    fn decrement(ref self: TContractState);
    fn get_curr_count(self: @TContractState) -> felt252;
}

#[starknet::contract]
mod Counter {
    #[storage]
    struct Storage {
        counter: felt252, 
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn increment(ref self: ContractState){
            let count = self.counter.read();
            self.counter.write(count + 1);
        }
        fn decrement(ref self: ContractState){
            let count = self.counter.read();
            self.counter.write(count - 1);
        }
        fn get_curr_count(self: @ContractState) -> felt252 {
            self.counter.read()
        }
    }
}
// #[starknet::interface]
// pub trait IHelloStarknet<TContractState> {
//     fn increase_balance(ref self: TContractState, amount: felt252);
//     fn get_balance(self: @TContractState) -> felt252;
// }

// #[starknet::contract]
// mod HelloStarknet {
//     #[storage]
//     struct Storage {
//         balance: felt252, 
//     }

//     #[abi(embed_v0)]
//     impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
//         fn increase_balance(ref self: ContractState, amount: felt252) {
//             assert(amount != 0, 'Amount cannot be 0');
//             self.balance.write(self.balance.read() + amount);
//         }

//         fn get_balance(self: @ContractState) -> felt252 {
//             self.balance.read()
//         }
//     }
// }
