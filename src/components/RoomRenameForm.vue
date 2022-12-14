<template>
  <form v-on:submit="rename(name)">
    <input v-model="name" type="text" placeholder="New Name" required>
    <input class="submit-button" type="submit" value="Confirm">
  </form>
</template>

<script>

export default {
  name: 'RoomRenameForm',
  data: function() {
    return {
      name: null,
    }
  },
  methods: {
    rename(name) {
      this.$emit('close-rename-room', name);
    }
  }
}
</script>

<style lang="scss" scoped>
.form {
    padding: 10px;
    margin: auto;

  .submit-button {
    border: black;
    border-radius: 5px;
    padding: 2px;
  }

  input {
    border-radius: 5px;
    margin: auto;

    &:focus {
      outline: solid green;

      &:invalid {
        outline:solid red;
      }
    }
  }
}
</style>