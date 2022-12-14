<template>
  <div>
    <button class="button-add-window btn btn-secondary me-2" @click="toggleCreateForm">Create window</button>
    <div class="windows-list pt-3">
      <windows-list-item 
        v-for="window in windows"
        :window="window"
        :key="window.id"  
        @window-updated="updateWindow"
        @window-delete="deleteWindow"
      >
      </windows-list-item>
    </div>
    <template v-if="createFormOpened">
      <window-create-form class="form" @close-create-window="handleCreateForm" @toggle-popup="toggleCreateForm"></window-create-form>
    </template>
  </div>
</template>


<script>
import axios from 'axios';
import {API_HOST} from '@/config';
import WindowsListItem from './WindowsListItem';
import WindowCreateForm from './WindowCreateForm';


export default {
  components: {
    WindowsListItem,
    WindowCreateForm
  },
  name: 'WindowsList',
  data: function() {
    return {
      /* Initialize windows with an empty array, while waiting for actual data to be retrieved from the API */
      windows: [],
      createFormOpened: false,
    }
  },
  created: async function() {
    let response = await axios.get(`${API_HOST}/api/windows`);
    this.windows = response.data;
  },
  methods: {
    updateWindow(newWindow) {
      /* Find the place of window object with the same id in the array, and replace it */
      let index = this.windows.findIndex(window => window.id === newWindow.id);
      this.windows.splice(index, 1, newWindow);
    },
    deleteWindow(id){
      let index = this.windows.findIndex(window => window.id === id);
      this.windows.splice(index,1);
    },
    toggleCreateForm() {
      this.createFormOpened = !this.createFormOpened;
    },
    handleCreateForm(newWindow){
      this.createFormOpened = false;
      this.windows.push(newWindow.data);
    }
  }
}
</script>


<style lang="scss" scoped>
.button-add-window {
  margin-top: 20px;
}

.form{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
