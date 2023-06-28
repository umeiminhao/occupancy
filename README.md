# occupancy.aleo


## name
Anonym Counter

## Summary
This Dapp is for commuity opinion poll or vote anonymously.


## Application Values
1. This Dapp utilizes Aleo features on zk-SNARKs to ensure individual privacy and data security.

2. It could be used as a fundamental tool for Aleo community, in case of poll, vote or statistics related activites.


## User Flow
1. The moderator initiates a poll with options.

2. The participant choose an option and summit.

3. The result will be shown on terminals of all participants.


## How to Build

To compile this Aleo program, run:
```bash
aleo build
```

## How to Run
```bash
leo run account 'address'
```
Enter the user's wallet address, create an account, and return participant information

```bash
leo run optionVote 'address' 'id_number'
```
Enter the user's wallet address, option ID to be created by the user, create statistical options, and output option content `VoteToken`

```bash
leo run castVote 'Token' 'VoteToken'
```
Enter participant information, option content `VoteToken`, select statistical options, and return statistical quantity and other information

```bash
leo run results 'VoteToken'
```
Enter statistical options, complete the statistics, and return the statistical results



## Parameter Description
```bash
Token =>  {
    owner: address,
    gates: u64,
    is_vote: bool,
}

 VoteToken => {
    owner: address,
    gates: u64,
    vote_number: u64,
    id_number: u64
}
```

`owner`  User wallet address

`is_vote`  Statistics or not

`vote_number`  count

`id_number`  Statistical Option ID




