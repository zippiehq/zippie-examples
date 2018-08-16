<template>
  <div class="vault">
    <p>
      <a href="https://github/zippiehq/vault-api" target="_blank" rel="noopener">vault-api documentation</a>.
    </p>

     <div v-if="this.vaultInited == false">
       <button v-on:click="vaultinit"  :disabled="this.vaultInitialising == true">Sign-in with Zippie</button>
     </div>
     <div v-else>
       <input v-model="messageToSign" placeholder="Message To Sign"/>
       <button v-on:click="vaultSign('m/0', messageToSign)">Sign</button>

       <pre>
         <b>Sign Output: </b><br />
         {{ this.signOutput | pretty }}
       </pre>

       <input v-model="messageToEncrypt" placeholder="Message To Encrypt" />
       <button v-on:click="vaultEncrypt(messageToEncrypt)">Encrypt</button> 
     
      <pre>
        <b> Encrypt Output:</b><br/>
        {{ this.encryptOutput | pretty }}
      </pre>
    </div>
  </div>
</template>

<script>
const vault = require("vault-api")
const vaultSecp256k1 = require("vault-api/src/secp256k1.js");
const shajs = require('sha.js');
import { getCookie, setCookie } from 'tiny-cookie'

const vaultOpts = {vaultURL: 'https://vault.dev.zippie.org'}

export default {
  name: 'Vault',

  created: function ()
  {
    var signInWith = getCookie('autoSignInWith');

    if(signInWith == 'zippieVault')
    {
      this.vaultInitialising = true;

      vault.init(vaultOpts).then(
        result => {
          this.vaultInited = true
        }
      );
    }
  },
  data: function ()
  {
    return {
      messageToSign: "",
      messageToEncrypt: "",
      signOutput: '{"result": {}}',
      encryptOutput: '{"result": {}}',
      vaultInited: false,
      vaultInitialising: false
    }
  },
  filters: {
    pretty: function(value) {
      return JSON.stringify(JSON.parse(value), null, 2)
    }
  },
  methods: {
    vaultinit: function() {

      setCookie('autoSignInWith','zippieVault')

      vault.init(vaultOpts).then(
        result => {
          this.vaultInited = true
        }
      );
    },
   vaultSign: function(keyPath, messageToSign) {
     vaultSecp256k1
      .sign(vault, keyPath, shajs('sha256').update(messageToSign).digest())
      .then(signedOutput => {
        this.signOutput = JSON.stringify(signedOutput)
      });
   },

   vaultEncrypt: function(messageToEncrypt) {
      vaultSecp256k1.keyInfo(vault, 'm/0').then(keyInfo => {
        vaultSecp256k1
          .encrypt(vault, keyInfo.pubkey, Buffer.from(messageToEncrypt).toString('hex'))
          .then(encryptedMessage => {
            this.encryptOutput = JSON.stringify(encryptedMessage);
        });
     });
   },

   vaultDecrypt: function(encryptedMessage) {
     vaultSecp256k1
       .decrypt(vault, 'm/0', encryptedMessage)
       .then(message => {
           this.vaultOutput(message);
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
