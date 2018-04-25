const SHA256 = require('crypto-js/sha256.js');

class Transaction{
    constructor(fromAddress, toAddress, amount){
        this.fromAddress = fromAddress;
        this.toAddress = toAddress;
        this.amount = amount;
    }
}
class Block{
    constructor(timestamp, transactions, previousHash = ''){
        this.timestamp = timestamp;
        this.transactions = transactions;
        this.previousHash =previousHash;
        this.hash = this.calculateHash();
        this.nonce = 0;
    }
    calculateHash(){
        //SHA-256
        return SHA256(this.previousHash+ this.timestamp+ JSON.stringify(this.transactions)+this.nonce).toString()
    }
    mineBlock(difficulty){
        while(this.hash.substring(0,difficulty)!==  Array(difficulty+1).join('0')){
            this.nonce++;
            this.hash = this.calculateHash();
        }
        console.log('Block Mined: '+this.hash)
    }
}

class Blockchain{
    constructor(){
        this.chain=[this.createGenesisBlock()];//initialise the array of blocks
        this.difficulty = 2;
        this.pendingTransactions = [];
        this.miningReward = 100;
    }
    createGenesisBlock(){
        return new Block(0,'01/01/2018','Genesis Block','0');
    }
    getLatestBlock(){
        return this.chain[this.chain.length-1];
    }
    // addBlock(newBlock){
    //     newBlock.previousHash = this.getLatestBlock().hash;
    //     //newBlock.hash = newBlock.calculateHash();
    //     newBlock.mineBlock(this.difficulty);
    //     this.chain.push(newBlock);
    // }
    minePendingTransaction(miningRewardAddress){
        let block =  new Block(Date.now(),this.pendingTransactions);
        block.mineBlock(this.difficulty);

        console.log('block successfully mined!');
        this.chain.push(block);

        this.pendingTransactions=[
            new Transaction(null, miningRewardAddress,this.miningReward)
        ];
    }
    createTransactions(transaction){
        this.pendingTransactions.push(transaction);
    }
    getBalanceOfAddress(address){
        let balance = 0;
        for(const block of this.chain){
            for(const trans of block.transactions){
                if(trans.fromAddress=== address){
                    balance -=trans.amount;
                }
                if(trans.toAddress === address){
                    balance+=trans.amount;
                }
            }
        }
        return balance;
    }
    isChainValid(){
        for(let i = 1; i< this.chain.length; i++){
            const currentBlock = this.chain[i];
            const previousBlock = this.chain[i -1];

            if(currentBlock.hash!== currentBlock.calculateHash()){
                return false;
            }

            if(currentBlock.previousHash !==previousBlock.hash){
                return false;
            }
        }
        return true;
    }
}

let savjeeCoin = new Blockchain();
// console.log('Mining Block 1...');
// savjeeCoin.addBlock(new Block(1,'10/07/2018',{amount:4}));
// console.log('Mining Block 2...');
// savjeeCoin.addBlock(new Block(2,'12/07/2018',{amount:10}));
//console.log(JSON.stringify(savjeeCoin,null,4));
//console.log('is block chain valid? '+ savjeeCoin.isChainValid())
//savjeeCoin.chain[1].data = {amount:100};
//console.log('is blockchain valid? ' +savjeeCoin.isChainValid())
savjeeCoin.createTransactions(new Transaction('address1','address2',100));
savjeeCoin.createTransactions(new Transaction('address2','address1',50));

console.log('\n starting the miner...');
savjeeCoin.minePendingTransaction('xavier-address');

console.log('\n Balance of xavier is ', savjeeCoin.getBalanceOfAddress('xavier-address'));

console.log('\n starting the miner again...');
savjeeCoin.minePendingTransaction('xavier-address');

console.log('\n Balance of xavier is ', savjeeCoin.getBalanceOfAddress('xavier-address'));