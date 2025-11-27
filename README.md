# Foundry NFT examples (BasicNFT + MoodNft)

This repository is a small Solidity/Foundry learning project that demonstrates two simple ERC-721 (NFT)
contracts and associated tests built using Foundry (forge + forge-std):

- `BasicNFT` (src/BasicNFT.sol): a simple ERC-721 with a constant `tokenURI` and a basic `mintNft` method.
- `MoodNft` (src/MoodNft.sol): an on-chain “mood” NFT which returns a data:URI JSON (base64) with an SVG image that changes depending on the token's mood.

This repository includes small tests showing how to use forge-std Test helpers and unit tests for those contracts.

---

## Project structure 🔎

- `src/` - Solidity smart contracts
  - `BasicNFT.sol` - simple example NFT
  - `MoodNft.sol` - NFT with two moods and on-chain image + metadata
- `script/` - small deploy scripts used by tests/learning
- `test/` - test files written using Foundry (`forge-std/Test.sol`)
- `lib/` - external libraries added (OpenZeppelin, forge-std, foundry-devops, etc.)

---

## How to run tests (Foundry)

Make sure you have Foundry (forge/cast) installed: https://github.com/foundry-rs/foundry

From the project root:

```bash
forge test
```

If you want more output:

```bash
forge test -vv
```

Note: While running tests earlier I discovered one compile-time issue in `MoodNft` that prevented test execution (OpenZeppelin removed `_isApprovedOrOwner` in recent versions in favor of `_isAuthorized`). That issue has been fixed in `src/MoodNft.sol` to use the current OpenZeppelin pattern, so the tests should compile now.

---

## Tests explained (what each file checks) ✅

This section details the tests under the `test/` folder and what they do.

### test/BasicNftTest.t.sol
- setUp(): deploys the `BasicNFT` contract using `script/DeployBasicNft.s.sol`.
- testNameIsCorrect(): checks that the NFT's `name()` returns the expected value "Dogie". This uses a keccak256 string comparison.
- testCanMintAndHaveABalance(): simulates another address (with `vm.prank(USER)`), calls `mintNft(TOKEN_URI)`, and asserts
  - `balanceOf(USER) == 1` after minting, and
  - `tokenURI(0)` returns the expected token URI (compares keccak256 of the strings).

This test demonstrates basic minting behavior and metadata retrieval for a simple ERC721 implementation.

### test/MoodNftTest.t.sol
- setUp(): deploys an instance of `MoodNft` with a `SAD` and `HAPPY` SVG data URI passed to the constructor.
- testTokenURI(): calls `mitNft()` to mint a token (note: the contract uses the `mitNft` naming), then calls `tokenURI(0)` under a `vm.prank(USER)` context and logs the token URI.
  - The actual assertion is commented out (`assert(bytes(tokenUri).length > 0)`) so this test currently only calls `tokenURI` and logs the returned string.

This file demonstrates a mint and metadata call for the on-chain mood NFT, but it doesn't assert on mood switching or flipping — that could be added by tests that exercise `flipMood` and the access control behavior (owner/approved checks).

---

## Notes & suggestions (improvements) 💡

- Add tests for `flipMood` to verify only the token owner or an approved operator can change the mood and that mood toggles are reflected in the `tokenURI` (i.e., the embedded `image` changes between the provided SVGs).
- Fix the `BasicNFT` contract to actually use the stored mapping `s_tokenIdToUri` (currently `tokenURI` returns a constant string and `mintNft` stores values but doesn't return them).
- Add more robust tests to check behavior for non-existent tokens, edge cases, and reverts.

---

If you'd like, I can also:
- run the test suite on your machine and paste the results here (if you want me to attempt running them again), or
- add more tests that cover `flipMood`, ownership checks, and corner cases.

---

Happy to expand or polish this README with additional instructions (CI, coverage, examples) — tell me which way you'd like to go next.
