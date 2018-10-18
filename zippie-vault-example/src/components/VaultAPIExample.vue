<template>
    <div>
       <input v-model="vaultPath">

       <input v-model="messageToSign" placeholder="Message To Sign"/>
       <button v-on:click="vaultSign(vaultPath, messageToSign)">Sign</button>

       <pre>
         <b>Sign Output: </b><br />
         {{ this.signOutput | pretty }}
       </pre>

       <input v-model="messageToEncrypt" placeholder="Message To Encrypt" />
       <button v-on:click="vaultEncrypt(vaultPath, messageToEncrypt)">Encrypt</button> 
     
      <pre>
        <b> Encrypt Output:</b><br/>
        {{ this.encryptOutput | pretty }}
      </pre>

       <input v-model="messageToDecrypt" placeholder="Message To Decrypt" />
       <button v-on:click="vaultDecrypt(vaultPath, messageToDecrypt)">Decrypt</button> 

      <pre>
        <b> Decrypt Output:</b><br/>
        {{ this.decryptOutput | pretty }}
      </pre>

    </div>
</template>

<script>
import * as vaultSecp256k1 from "@zippie/vault-api/src/secp256k1.js"
import * as shajs from 'sha.js'

export default {
    name: 'VaultAPIExample',
    props: ['vault'],
    data: function()
    {
        return {
            vaultPath: 'm/0',
            messageToSign: "",
            messageToEncrypt: "",
            messageToDecrypt: "",
            signOutput: '{"result": {}}',
            encryptOutput: '{"result": {}}',
            decryptOutput: '{"result": {}}'
        }
    },
    filters: {
        pretty: function(value) {
        return JSON.stringify(JSON.parse(value), null, 2)
        }
  },
  methods: {
         vaultSign: function(keyPath, messageToSign) {
     vaultSecp256k1
      .sign(this.vault, keyPath, shajs('sha256').update(messageToSign).digest())
      .then(signedOutput => {
        this.signOutput = JSON.stringify(signedOutput)
      });
   },

   vaultEncrypt: function(vaultPath, messageToEncrypt) {
      vaultSecp256k1.keyInfo(this.vault, vaultPath)
        .then(keyInfo => {
          vaultSecp256k1
            .encrypt(this.vault, keyInfo.pubkey, Buffer.from(messageToEncrypt).toString('hex'))
            .then(encryptedMessage => {
              this.encryptOutput = JSON.stringify(encryptedMessage);
              this.messageToDecrypt = encryptedMessage.result;
          });
       });
   },

   vaultDecrypt: function(vaultPath, encryptedMessage) {
     vaultSecp256k1
       .decrypt(this.vault, vaultPath, encryptedMessage)
       .then(message => {
           this.decryptOutput = Buffer.from(message.result, 'hex').toString();
        });
    }
  }
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>