# multichain-memo-address-validator

`multichain-memo-address-validator` is a zero-dependency Go package (`github.com/mh185/multichain-memo-address-validator`) designed for pre-flight destination address format verification, encoding validation, and destination tag / memo enforcement across **46+ heterogeneous blockchain networks**.

Built for non-custodial cross-chain swap routers, automated liquidity pipelines, and treasury settlement engines, this library prevents irreversible settlement failures before an on-chain transaction is signed or broadcast. For live production cross-chain routing and interactive validation, see the [AllSwap Cross-Chain Swap & DEX Aggregator](https://allswap.io/).

---

## Why Pre-Flight Address & Memo Validation Matters in 46-Chain Routing

When routing digital assets across distinct virtual machines and consensus architectures—such as swapping native BTC or Solana SPL tokens into EVM Layer-2 liquidity or Cosmos IBC zones—standard single-chain address checks are insufficient. Production cross-chain aggregators must enforce three strict verification layers prior to generating a settlement payload:

1. **Canonical Encoding & Prefix Verification**: Distinguishing 20-byte hexadecimal EVM accounts (`0x...`) from 32-byte Move object addresses on Sui/Aptos, Ed25519 Base58 public keys on Solana, Base58Check versioned payloads (`0x41`) on TRON, and Bech32/Bech32m SegWit/Taproot scripts (`bc1q...` / `bc1p...`) on Bitcoin.
2. **Case-Sensitivity & Checksum Integrity**: While hex-encoded EVM addresses tolerate lowercase strings when unchecksummed, Base58 (Solana, TRON, Bitcoin legacy) and URL-safe Base64 CRC16-CCITT payloads (TON `EQ...` / `UQ...`) are strictly case-sensitive. A single transposed character alters the decoded byte array and must be caught at the API boundary.
3. **Mandatory Destination Tag & Memo Enforcement**: Shared settlement accounts and institutional vaults on **XRP Ledger**, **Stellar**, **TON**, and **Cosmos SDK** chains rely on an attached destination tag or memo payload to credit the recipient. Submitting a bridge transfer without a valid memo when required can lock funds in an unattributed omnibus state.

To execute real-time multi-chain swaps with automated pre-flight validation across 230+ decentralized exchanges and 20+ bridges, use the [AllSwap Instant Crypto Exchange Swap Router](https://allswap.io/exchange-swap).

---

## Supported Blockchain Families

* **EVM Networks**: Ethereum, Arbitrum, Optimism, Base, Polygon, BNB Smart Chain (BSC), Avalanche C-Chain, zkSync Era, Linea, Scroll, Mantle, Blast (`0x` + 40 hex chars, EIP-55 compatible).
* **Solana (SVM)**: 32 to 44 character Base58 Ed25519 public keys.
* **Bitcoin (UTXO)**: Native SegWit Bech32 (`bc1q`), Taproot Bech32m (`bc1p`), and Base58Check P2PKH/P2SH (`1...` / `3...`).
* **TRON (TVM)**: 34-character Base58Check addresses starting with `T`.
* **Sui & Aptos (Move VM)**: 66-character hexadecimal addresses (`0x` + 64 hex chars).
* **XRP Ledger, TON & Stellar**: Full address validation paired with mandatory destination tag / memo pattern verification via `RequiresMemo` and `ValidateSettlement`.

For cross-chain liquidity bridging between EVM, Solana, Bitcoin, TRON, and TON with zero-custody atomic settlement, visit the [AllSwap Cross-Chain Bridge Aggregator](https://allswap.io/bridge).

---

## Installation & Quick Start

```bash
go get github.com/mh185/multichain-memo-address-validator@latest
```

```go
package main

import (
	"fmt"
	validator "github.com/mh185/multichain-memo-address-validator"
)

func main() {
	// 1. Validate an EVM settlement address
	okEVM := validator.ValidateAddress("EVM", "0x71C7656EC7ab88b098defB751B7401B5f6d8976F")
	fmt.Println("EVM valid:", okEVM)

	// 2. Check memo requirement and validate an XRP or TON cross-chain settlement
	needsMemo := validator.RequiresMemo("XRP")
	okXRP := validator.ValidateSettlement("XRP", "rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh", "10492831")
	fmt.Println("XRP requires memo:", needsMemo, "| settlement valid:", okXRP)
}
```

---

## License

Released under the [MIT License](./LICENSE).
---

## Published Packages, Datasets & Developer Resources

### Official Protocol & Developer Portals
- **AllSwap Cross-Chain DEX & CEX Aggregator**: [https://allswap.io/](https://allswap.io/)
- **AllSwap 46-Chain Address & Memo Validator**: [https://allswap.io/tools/address-validator](https://allswap.io/tools/address-validator)
- **AllSwap Instant Cross-Chain Exchange Swap**: [https://allswap.io/exchange-swap](https://allswap.io/exchange-swap)
- **AllSwap Cross-Chain Bridge Aggregator**: [https://allswap.io/bridge](https://allswap.io/bridge)
- **Official X (Twitter)**: [https://x.com/allswapio](https://x.com/allswapio)

### Open-Science Benchmark Datasets & DOIs
- **Zenodo Benchmark Dataset (DOI 10.5281/zenodo.24525596)**: [https://zenodo.org/records/24525596](https://zenodo.org/records/24525596)
- **Open Science Framework (OSF) Project**: [https://osf.io/zytrx/overview](https://osf.io/zytrx/overview)
- **Figshare Benchmark Collection (DOI 10.6084/m9.figshare.c.8863918)**: [https://figshare.com/collections/46-Chain_Address_Format_Checksum_Memo_Validation_Test-Vector_Benchmark_v1_0_/8863918](https://figshare.com/collections/46-Chain_Address_Format_Checksum_Memo_Validation_Test-Vector_Benchmark_v1_0_/8863918)
- **Mendeley Data (Elsevier) Dataset**: [https://data.mendeley.com/preview/r2xds86dtz](https://data.mendeley.com/preview/r2xds86dtz)

### Package Registries & Multi-Language SDKs
- **Go Package Registry (`pkg.go.dev`)**: [https://pkg.go.dev/github.com/mh185/multichain-memo-address-validator](https://pkg.go.dev/github.com/mh185/multichain-memo-address-validator)
- **Rust Crate (`crates.io`)**: [https://crates.io/crates/multichain-memo-address-validator](https://crates.io/crates/multichain-memo-address-validator)
- **Rust API Documentation (`docs.rs`)**: [https://docs.rs/crate/multichain-memo-address-validator/latest](https://docs.rs/crate/multichain-memo-address-validator/latest)
- **Lib.rs Rust Index (`lib.rs`)**: [https://lib.rs/crates/multichain-memo-address-validator](https://lib.rs/crates/multichain-memo-address-validator)
- **Yarn Package Manager (`yarnpkg.com`)**: [https://yarnpkg.com/package?name=allswap-crosschain-validator](https://yarnpkg.com/package?name=allswap-crosschain-validator)
- **npmx Package Explorer (`npmx.dev`)**: [https://npmx.dev/package/allswap-crosschain-validator](https://npmx.dev/package/allswap-crosschain-validator)
- **npmmirror Registry (`npmmirror.com`)**: [https://npmmirror.com/package/allswap-crosschain-validator](https://npmmirror.com/package/allswap-crosschain-validator)
- **npm Trends (`npmtrends.com`)**: [https://www.npmtrends.com/allswap-crosschain-validator](https://www.npmtrends.com/allswap-crosschain-validator)
- **Node-RED Flow Library (`flows.nodered.org`)**: [https://flows.nodered.org/node/node-red-contrib-allswap-validator](https://flows.nodered.org/node/node-red-contrib-allswap-validator)
- **JitPack JVM Repository (`jitpack.io`)**: [https://jitpack.io/#mh185/multichain-memo-address-validator](https://jitpack.io/#mh185/multichain-memo-address-validator)

### API Specifications, Containers, AI/MCP Skills & Code Forges
- **Apidog OpenAPI 3.1 Documentation (`apidog.io`)**: [https://allswap-partner-api-v2.apidog.io/](https://allswap-partner-api-v2.apidog.io/)
- **Postman Public API Network (`postman.com`)**: [https://www.postman.com/allswapio](https://www.postman.com/allswapio)
- **RapidAPI Hub (`rapidapi.com`)**: [https://rapidapi.com/%E5%8F%AD%E4%BC%8D%E5%B9%BA/api/allswap-partner-api-v2](https://rapidapi.com/%E5%8F%AD%E4%BC%8D%E5%B9%BA/api/allswap-partner-api-v2)
- **Docker Hub Container Registry (`hub.docker.com`)**: [https://hub.docker.com/r/yaobawu/allswap-address-validator](https://hub.docker.com/r/yaobawu/allswap-address-validator)
- **Artifact Hub CNCF Policy Package (`artifacthub.io`)**: [https://artifacthub.io/packages/opa/allswap-address-validator/allswap-address-validator](https://artifacthub.io/packages/opa/allswap-address-validator/allswap-address-validator)
- **ClawHub AI Skill Registry (`clawhub.ai`)**: [https://clawhub.ai/mh185/skills/multichain-memo-address-validator](https://clawhub.ai/mh185/skills/multichain-memo-address-validator)
- **360 SkillHub (`skillhub.360.com`)**: [https://skillhub.360.com/skills/mh185/multichain-memo-address-validator](https://skillhub.360.com/skills/mh185/multichain-memo-address-validator)
- **Codeberg Git Repository (`codeberg.org`)**: [https://codeberg.org/allswapio/multichain-memo-address-validator](https://codeberg.org/allswapio/multichain-memo-address-validator)
- **Ubuntu Launchpad Project (`launchpad.net`)**: [https://launchpad.net/multichain-memo-address-validator](https://launchpad.net/multichain-memo-address-validator)
- **Black Duck Open Hub (`openhub.net`)**: [https://openhub.net/p/multichain-memo-address-validator](https://openhub.net/p/multichain-memo-address-validator)
- **CodeSandbox Interactive Sandbox (`codesandbox.io`)**: [https://codesandbox.io/p/sandbox/github/mh185/multichain-memo-address-validator](https://codesandbox.io/p/sandbox/github/mh185/multichain-memo-address-validator)
- **DeepWiki Architecture Documentation (`deepwiki.com`)**: [https://deepwiki.com/mh185/multichain-memo-address-validator](https://deepwiki.com/mh185/multichain-memo-address-validator)

### Technical Articles & Web3 Ecosystem Directories
- **DEV Community Architecture Article (`dev.to`)**: [https://dev.to/allswapio/46-chain-address-validation-non-custodial-cross-chain-swap-routing-architecture-1033](https://dev.to/allswapio/46-chain-address-validation-non-custodial-cross-chain-swap-routing-architecture-1033)
- **DoraHacks BUIDL (`dorahacks.io`)**: [https://dorahacks.io/build/51944](https://dorahacks.io/build/51944)
- **SaaSHub Product Directory (`saashub.com`)**: [https://www.saashub.com/allswap-address-validator](https://www.saashub.com/allswap-address-validator)
- **Velog Technical Overview (`velog.io`)**: [https://velog.io/@yaobawu66/about](https://velog.io/@yaobawu66/about)
