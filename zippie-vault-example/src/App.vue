<template>
  <div id="app">
    <img alt="Zippie logo" src="./assets/logo.png">
    <h2>Zippie Vault Example</h2>
    <p>
      <a href="https://github/zippiehq/vault-api" target="_blank" rel="noopener">vault-api documentation</a>.
    </p>
    <Vault>
      <template scope="{vault}">
        <VaultAPIExample :vault="vault" />
      </template>
    </Vault>
  </div>
</template>

<script>
import Vault from './components/Vault.vue'
import VaultAPIExample from './components/VaultAPIExample.vue'

export default {
  name: 'app',
  components: {
    Vault,
    VaultAPIExample
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
