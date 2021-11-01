web3.personal.unlockAccount(eth.coinbase, "", 0);
function mineTrans() {
  var startTime = new Date().getTime();
  var startBlock = eth.blockNumber;
  var startTrans = eth.getBlock("pending").transactions.length;
  var startTransTime = new Date().getTime();

  a = "0xbe5c1e902fb2784f51b775d28233da6ad5316a61"
  b = 0.0001
  eth.sendTransaction({from: eth.coinbase, to: a, value: web3.toWei(b, "ether")});
  

  var endTransTime = new Date().getTime();

  var endTrans = eth.getBlock("pending").transactions.length;

  //}
  var startMineTime = new Date().getTime();
  status = 1;
  while(status){

   
    if (txpool.status.pending > 0 && status==1) {
      miner.start();
      status = status+1;
    } else if(txpool.status.pending == 0) {
      miner.stop();
      status=0
      console.log("Transaction(s) successful!!!");

  var endMineTime = new Date().getTime();
  var endBlock = eth.blockNumber;
  var block = endBlock - startBlock;
  var transNumber = endTrans - startTrans;
  var transTime = endTransTime - startTransTime;
  var mineTime = endMineTime - startMineTime;

  var endTime = new Date().getTime();
  var time = endTime - startTime;
  console.log(block, transNumber, transTime, mineTime, time);

      

    }
  }
}
