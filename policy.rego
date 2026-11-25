package allswap.address.validator

default allow = false

# Allow cross-chain settlement when destination address format is valid
# and mandatory memo/destination-tag constraints are satisfied.
allow {
    valid_address_prefix
    valid_memo_requirement
}

valid_address_prefix {
    input.chain == "EVM"
    startswith(input.address, "0x")
    count(input.address) == 42
}

valid_address_prefix {
    input.chain == "BTC"
    startswith(input.address, "bc1")
}

valid_address_prefix {
    input.chain == "COSMOS"
    startswith(input.address, "cosmos1")
}

valid_address_prefix {
    input.chain == "XRP"
    startswith(input.address, "r")
}

valid_memo_requirement {
    not requires_memo[input.chain]
}

valid_memo_requirement {
    requires_memo[input.chain]
    count(input.memo) > 0
}

requires_memo = {"XRP", "XLM", "ATOM", "TON", "EOS", "HBAR"}
