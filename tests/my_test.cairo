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