<template>
  <div id="app">
    <img alt="Zippie logo" src="./assets/logo.png">
    <h2>Zippie Vault Example</h2>
    <Vault />
  </div>
</template>

<script>
import Vault from './components/Vault.vue'

export default {
  name: 'app',
  components: {
    Vault
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
