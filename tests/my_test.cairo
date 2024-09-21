use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

// use counter_contract::ICounterSafeDispatcher;
// use counter_contract::ICounterSafeDispatcherTrait;
use counter_contract::ICounterDispatcher;
use counter_contract::ICounterDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]
fn test_increment() {
    let contract_address = deploy_contract("Counter");

    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.increment();
}

#[test]
fn test_decrement() {
    let contract_address = deploy_contract("Counter");
    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.decrement();
}
#[test]
fn test_get_counter() {
    let contract_address = deploy_contract("Counter");
    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.get_curr_count();
}


// #[test]
// #[feature("safe_dispatcher")]
// fn test_cannot_increase_balance_with_zero_value() {
//     let contract_address = deploy_contract("Counter");

//     let safe_dispatcher = ICounterSafeDispatcher { contract_address };

//     let balance_before = safe_dispatcher.get_balance().unwrap();
//     assert(balance_before == 0, 'Invalid balance');

//     match safe_dispatcher.increase_balance(0) {
//         Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
//         Result::Err(panic_data) => {
//             assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data.at(0));
//         }
//     };
// }
